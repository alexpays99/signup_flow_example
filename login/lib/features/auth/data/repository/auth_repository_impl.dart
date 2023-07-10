import 'dart:async';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:login/features/auth/data/models/credential_model.dart';
import 'package:login/features/auth/data/models/facebook_data_model.dart';
import 'package:login/features/auth/data/models/sign_up_data_model.dart';
import 'package:login/features/auth/domain/entity/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:login/features/auth/domain/entity/credentials_entity.dart';
import 'package:login/features/auth/domain/entity/login_google_data_entity.dart';
import 'package:login/features/auth/domain/entity/sign_up_data_entity.dart';
import 'package:login/features/auth/domain/entity/user_token.dart';
import 'package:login/features/auth/domain/repository/auth_repository.dart';
import 'package:login/features/auth/sevices/auth_service.dart';
import 'package:login/features/auth/sevices/google_auth_service.dart';
import 'package:login/features/auth/sevices/timeout_service/timout_service.dart';
import 'package:login/features/auth/sevices/user_storage_service.dart';
import 'package:logger/logger.dart';

import '../models/login_google_data_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final UserStorageService userStorage;
  final AuthService authService;
  final GoogleAuthService googleAuthService;
  final TimeoutService timeoutService;
  final FacebookAuth facebookAuth;

  final StreamController<AuthRepositoryState> _stateStreamController =
      StreamController();

  AuthRepositoryImpl({
    required this.userStorage,
    required this.authService,
    required this.googleAuthService,
    required this.timeoutService,
    required this.facebookAuth,
  }) {
    _stateStreamController.sink.add(state);
    userStorage.haveTokens().then((value) {
      if (value) {
        _validateTokens().then((value) {
          if (value) {
            _updateState(AuthRepositoryState.signedIn);
          } else {
            userStorage.clearTokens();
            _updateState(AuthRepositoryState.signedOut);
          }
        });
      } else {
        _updateState(AuthRepositoryState.signedOut);
      }
    });
  }

  @override
  Future<Either<AuthFailure, UserTokens>> loginWIthFacebook() async {
    try {
      final LoginResult result = await facebookAuth.login(
        permissions: [
          'email',
          'public_profile',
          'user_birthday',
        ],
      );
      // by default we request the email and the public profile
      // or FacebookAuth.i.login()
      if (result.status == LoginStatus.success) {
        final facebookData = await facebookAuth.getUserData(
          fields: 'email, id, name, first_name, '
              'last_name, picture.type(large), birthday',
        );

        ///We need to check if user have an email otherwise backend will not
        ///accept this data
        final tokenResults = await authService.loginWIthFacebook(
          FacebookDataModel.fromFacebookJson(facebookData),
        );
        return tokenResults.fold(
          (l) {
            return Left(l);
          },
          (r) async {
            final saveResult = await userStorage.saveTokens(r.entity);
            return saveResult.fold(
              (l) => Left(AuthFailure.local(message: l.message)),
              (success) {
                _updateState(AuthRepositoryState.signedIn);
                return Right(r.entity);
              },
            );
          },
        );
      } else {
        return const Left(
            AuthFailure.local(message: 'Error during login with Facebook'));
      }
    } on ArgumentError catch (_) {
      return const Left(
          AuthFailure.facebookNoEmail(message: 'Exception caught'));
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Exception caught'));
    }
  }

  @override
  Future<Either<AuthFailure, UserTokens>> loginWithCredentials(
    CredentialEntity credentials,
  ) async {
    try {
      final userTokens = await authService
          .loginWithCredentials(CredentialsModel.fromEntity(credentials));
      return userTokens.fold(
        (l) {
          return Left(l);
        },
        (r) async {
          try {
            await userStorage.saveTokens(r.entity);
            _updateState(AuthRepositoryState.signedIn);
            return Right(r.entity);
          } catch (e) {
            return const Left(AuthFailure.local(
              message: 'Something wrong during login in auth repository',
            ));
          }
        },
      );
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<AuthFailure, bool>> requestSignOut() async {
    try {
      final signOutResult = await googleAuthService.signOut();
      return signOutResult.fold(
        (l) {
          return const Left(AuthFailure.local(message: 'Failed to sign out'));
        },
        (r) async {
          if (r == null) {
            final signoutResult = await googleAuthService.signOut();
            return signoutResult.fold(
              (l) {
                return const Left(
                    AuthFailure.local(message: 'Failed to sign out'));
              },
              (r) async {
                if (r == null) {
                  await userStorage.clearTokens();
                  _updateState(AuthRepositoryState.signedOut);
                  return const Right(true);
                } else {
                  return const Right(false);
                }
              },
            );
          } else {
            return const Right(false);
          }
        },
      );
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Failed to sign out'));
    }
  }

  @override
  Stream<AuthRepositoryState> getStateStream() {
    return _stateStreamController.stream;
  }

  @override
  Future<Either<AuthFailure, Duration>> requestCode(
      CredentialEntity credentials) async {
    try {
      final duration = await timeoutService.getTimeout();
      if (duration <= Duration.zero) {
        final result = await authService
            .requestCode(CredentialsModel.fromEntity(credentials));
        return result.fold(
          (l) => Left(l),
          (r) async {
            final newDuration = await timeoutService.countRequest();
            return Right(newDuration);
          },
        );
      } else {
        return Right(duration);
      }
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something wrong'));
    }
  }

  @override
  Future<Either<AuthFailure, bool>> validateCode({
    required CredentialEntity credentials,
    required String code,
  }) async {
    try {
      final result = await authService.validateCode(
          CredentialsModel.fromEntity(credentials), code);
      return result.fold(
        (l) => Left(l),
        (r) {
          return const Right(true);
        },
      );
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something wrong'));
    }
  }

  @override
  Future<Either<AuthFailure, UserTokens>> signUp(
      SignUpDataEntity userEntity) async {
    try {
      final userTokens =
          await authService.signUp(SignUpDataModel.fromEntity(userEntity));
      return userTokens.fold(
        (l) {
          return Left(l);
        },
        (r) async {
          try {
            await userStorage.saveTokens(r.entity);
            return Right(r.entity);
          } catch (e) {
            return const Left(AuthFailure.local(
              message: 'Something wrong during login in auth repository',
            ));
          }
        },
      );
    } catch (e) {
      return const Left(AuthFailure.local(message: 'error with request'));
    }
  }

  @override
  Future<Either<AuthFailure, UserTokens>> refreshTokens() async {
    try {
      final tokens = await userStorage.getTokens();
      return tokens.fold(
        (l) => Left(AuthFailure.local(message: l.message)),
        (r) async {
          final newTokens = await authService.refreshTokens(r.refreshToken);
          return newTokens.fold(
            (l) => Left(l),
            (r) async {
              final saveResult = await userStorage.saveTokens(r.entity);
              return saveResult.fold(
                (l) => Left(AuthFailure.local(message: l.message)),
                (r) async {
                  final tokens = await userStorage.getTokens();
                  return tokens.fold(
                    (l) => Left(AuthFailure.local(message: l.message)),
                    (r) => Right(r),
                  );
                },
              );
            },
          );
        },
      );
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something wrong'));
    }
  }

  void _updateState(AuthRepositoryState newState) {
    state = newState;
    _stateStreamController.sink.add(state);
  }

  Future<bool> _validateTokens() async {
    final tokens = await userStorage.getTokens();
    return tokens.fold(
      (l) {
        return false;
      },
      (r) {
        return true;
      },
    );
  }

  @override
  Future<Either<AuthFailure, bool>> checkUserEmailValid(String email) async {
    try {
      final checkEmail = await authService.validateUserEmail(email);
      return checkEmail.fold(
        (l) => Left(AuthFailure.remote(message: l.message)),
        (r) => Right(r),
      );
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something wrong'));
    }
  }

  @override
  Future<Either<AuthFailure, bool>> checkUserPhoneValid(String phone) async {
    try {
      final checkPhone = await authService.validateUserPhone(phone);
      return checkPhone.fold(
        (l) => Left(AuthFailure.remote(message: l.message)),
        (r) => Right(r),
      );
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something wrong'));
    }
  }

  @override
  Future<Either<AuthFailure, bool>> checkUserNicknameValid(
      String nickname) async {
    final logger = Logger();

    try {
      final checkNickname = await authService.validateUserNickname(nickname);
      logger.d(checkNickname);

      return checkNickname.fold(
        (l) => Left(AuthFailure.remote(message: l.message)),
        (r) => const Right(true),
      );
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something wrong'));
    }
  }

  @override
  Future<Either<AuthFailure, LoginGoogleDataEntity>?>
      getAllLoginGoogleData() async {
    try {
      final googleLoginData = await googleAuthService.getAllLoginGoogleData();
      return googleLoginData?.fold(
        (l) {
          return Left(l);
        },
        (r) {
          return Right(r.entity);
        },
      );
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<AuthFailure, UserTokens>> signInWithGoogleCredentials(
      LoginGoogleDataEntity loginGoogleDataModel) async {
    try {
      final userTokens = await googleAuthService.signInWithGoogleCredentials(
          LoginGoogleDataModel.fromEntity(loginGoogleDataModel));
      return userTokens.fold(
        (l) {
          return Left(l);
        },
        (r) async {
          try {
            await userStorage.saveTokens(r.entity);
            _updateState(AuthRepositoryState.signedIn);
            return Right(r.entity);
          } catch (e) {
            return const Left(AuthFailure.local(
              message: 'Something wrong during login in auth repository',
            ));
          }
        },
      );
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<AuthFailure, bool>> resetPassword(
      CredentialEntity credentialEntity) async {
    final response = await authService.changePassword(
      CredentialsModel.fromEntity(credentialEntity),
    );
    return response;
  }
}
