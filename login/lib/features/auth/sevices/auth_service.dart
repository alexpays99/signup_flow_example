import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login/core/keys/auth_service_data.dart';
import 'package:login/features/auth/data/models/credential_model.dart';
import 'package:login/features/auth/data/models/error_model.dart';
import 'package:login/features/auth/data/models/facebook_data_model.dart';
import 'package:login/features/auth/data/models/sign_up_data_model.dart';
import '../data/models/user_tokens_model.dart';
import '../domain/entity/auth_failure.dart';
import 'package:logger/logger.dart';

class AuthService {
  AuthService({
    required this.dio,
    required this.authServiceData,
  });

  final AuthServiceData authServiceData;
  final Dio dio;

  Future<Either<AuthFailure, UserTokensModel>> signUp(
      SignUpDataModel signUpDataModel) async {
    try {
      final response = await dio.post(
        authServiceData.signUpEndpoint,
        data: signUpDataModel.toJson(),
      );
      if (response.statusCode == 201) {
        try {
          final userTokensModel = UserTokensModel.fromJson(response.data);
          return Right(userTokensModel);
        } catch (e) {
          return const Left(
              AuthFailure.local(message: 'Error while parsing data'));
        }
      } else {
        return Left(
          AuthFailure.remote(
            message: 'Invalid response',
            code: response.statusCode,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AuthFailure.local(message: e.message));
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something Wrong'));
    }
  }

  Future<Either<AuthFailure, UserTokensModel>> loginWithCredentials(
      CredentialsModel credentialsModel) async {
    print(credentialsModel.toJson());
    final response = await dio.post(
      authServiceData.signInCredentialsEndpoint,
      data: credentialsModel.toJson(),
    );

    // Here should be implemented logic for status conde checking. Now its hardcoded
    if (credentialsModel.email == 'diablo@gmail.com' &&
        credentialsModel.password == '12345678Rr*') {
      try {
        // Here we should get response.data from real backend. Now its hardcoded
        final userTokensModel = UserTokensModel.fromJson({
          'accessToken': 'alsdhfaslkdjfhasdfj',
          'refreshToken': 'asdfl;sadhfasdgfkjasdfhasdf',
        });
        return Right(userTokensModel);
      } catch (e) {
        return const Left(
            AuthFailure.local(message: 'Error while parsing data'));
      }
    } else {
      return Left(AuthFailure.remote(
        message: 'Invalid response',
        code: response.statusCode,
      ));
    }
  }

  Future<Either<AuthFailure, bool>> validateAccessToken(
      String accessToken) async {
    // Here should be logic for tokens validation from backend side.
    // Now it always returns true
    return const Right(true);
    // try {
    //   final response = await dio.post(
    //     authServiceData.validateAccessTokenEndpoint,
    //     data: {"token": accessToken},
    //   );
    //   if (response.statusCode == 200) {
    //     return const Right(true);
    //   } else {
    //     return Left(_responseToFailure(response));
    //   }
  }

  Future<Either<AuthFailure, UserTokensModel>> refreshTokens(
      String refreshToken) async {
    try {
      final response = await dio.post(
        authServiceData.refreshTokensEndpoint,
        data: {"token": refreshToken},
      );
      if (response.statusCode == 200) {
        return Right(UserTokensModel.fromJson(response.data));
      } else {
        return Left(_responseToFailure(response));
      }
    } catch (e) {
      return const Left(AuthFailure.local(message: 'RequestError'));
    }
  }

  Future<Either<AuthFailure, bool>> requestCode(
      CredentialsModel credentialsModel) async {
    try {
      final response = await dio.post(
        authServiceData.createCode,
        data: credentialsModel.existingIdentifierJson(),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(_responseToFailure(response));
      }
    } catch (e) {
      return const Left(AuthFailure.local(message: 'RequestError'));
    }
  }

  Future<Either<AuthFailure, UserTokensModel>> loginWIthFacebook(
      FacebookDataModel facebookDataModel) async {
    try {
      final response = await dio.post(
        authServiceData.facebookLogin,
        data: facebookDataModel.toJson(),
      );
      if (response.statusCode == 201) {
        return Right(
          UserTokensModel.fromJson(response.data),
        );
      } else {
        return Left(
          _responseToFailure(response),
        );
      }
    } catch (e) {
      return const Left(
        AuthFailure.local(message: 'Exception caught in request'),
      );
    }
  }

  AuthFailure _responseToFailure(Response response) {
    final errorMessage = AuthErrorModel.fromJson(response.data).error;
    return AuthFailure.remote(
      message: errorMessage,
      code: response.statusCode,
    );
  }

  Future<Either<AuthFailure, bool>> validateUserEmail(String email) async {
    try {
      final response = await dio.post(
        authServiceData.checkUserEmail,
        data: {"email": email},
      );
      return _uniquenessCheck(response.statusCode);
    } catch (e) {
      return const Left(AuthFailure.remote(message: 'Request Error'));
    }
  }

  Future<Either<AuthFailure, bool>> validateUserPhone(String phone) async {
    try {
      final response = await dio.post(
        authServiceData.checkUserPhone,
        data: {"phoneNumber": phone},
      );
      return _uniquenessCheck(response.statusCode);
    } catch (e) {
      print("exception");
      return const Left(AuthFailure.remote(message: 'Request Error'));
    }
  }

  Either<AuthFailure, bool> _uniquenessCheck(int? code) {
    switch (code) {
      case 200:
        return const Right(true);
      case 404:
        return const Right(false);
      default:
        return Left(
          AuthFailure.remote(
            message: 'Unexpected code!',
            code: code,
          ),
        );
    }
  }

  Future<Either<AuthFailure, bool>> validateUserNickname(
      String nickname) async {
    final logger = Logger();
    try {
      final response = await dio.post(
        authServiceData.checkUserNickname,
        data: {"nickname": nickname},
      );
      logger.d(response);
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(_responseToFailure(response));
      }
    } catch (e) {
      return const Left(AuthFailure.remote(message: 'Request Error'));
    }
  }

  Future<Either<AuthFailure, bool>> changePassword(
      CredentialsModel model) async {
    try {
      final response = await dio.post(
        authServiceData.changePassword,
        data: model.toJson(),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(_responseToFailure(response));
      }
    } catch (e) {
      return const Left(AuthFailure.remote(message: 'Request Error'));
    }
  }
}
