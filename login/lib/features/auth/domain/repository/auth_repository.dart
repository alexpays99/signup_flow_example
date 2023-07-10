import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:login/features/auth/domain/entity/credentials_entity.dart';
import 'package:login/features/auth/domain/entity/login_google_data_entity.dart';
import 'package:login/features/auth/domain/entity/sign_up_data_entity.dart';

import '../entity/auth_failure.dart';
import '../entity/user_token.dart';

enum AuthRepositoryState {
  signedIn,
  signedOut,
  unidentified,
}

abstract class AuthRepository {
  AuthRepositoryState state = AuthRepositoryState.unidentified;

  Stream<AuthRepositoryState> getStateStream();

  Future<Either<AuthFailure, UserTokens>> loginWithCredentials(
      CredentialEntity credentials);

  Future<Either<AuthFailure, UserTokens>> signUp(SignUpDataEntity userEntity);

  Future<Either<AuthFailure, bool>> requestSignOut();

  Future<Either<AuthFailure, UserTokens>> refreshTokens();

  Future<Either<AuthFailure, Duration>> requestCode(
      CredentialEntity credentials);

  Future<Either<AuthFailure, bool>> validateCode({
    required CredentialEntity credentials,
    required String code,
  });

  Future<Either<AuthFailure, UserTokens>> loginWIthFacebook();

  Future<Either<AuthFailure, LoginGoogleDataEntity>?> getAllLoginGoogleData();

  Future<Either<AuthFailure, UserTokens>> signInWithGoogleCredentials(
      LoginGoogleDataEntity loginGoogleDataModel);

  Future<Either<AuthFailure, bool>> resetPassword(
      CredentialEntity credentialEntity);

  Future<Either<AuthFailure, bool>> checkUserEmailValid(String email);

  Future<Either<AuthFailure, bool>> checkUserPhoneValid(String phone);

  Future<Either<AuthFailure, bool>> checkUserNicknameValid(String nickname);
}
