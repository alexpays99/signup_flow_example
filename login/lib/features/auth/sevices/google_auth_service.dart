import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/core/keys/google_auth_service_data.dart';
import 'package:logger/logger.dart';

import '../../../core/injection_container.dart';
import '../../../core/keys/auth_service_data.dart';
import '../data/models/error_model.dart';
import '../data/models/login_google_data_model.dart';
import '../data/models/user_tokens_model.dart';
import '../domain/entity/auth_failure.dart';

class GoogleAuthService {
  GoogleAuthService({
    required this.dio,
    required this.authServiceData,
    required this.googleAuthServiceData,
    required this.googleSignIn,
  });

  final AuthServiceData authServiceData;
  final GoogleAuthServiceData googleAuthServiceData;
  final Dio dio;
  final GoogleSignIn googleSignIn;
  final logger = Logger();

  AuthFailure _responseToFailure(Response response) {
    final errorMessage = AuthErrorModel.fromJson(response.data).error;
    return AuthFailure.remote(
      message: errorMessage,
      code: response.statusCode,
    );
  }

  Future<Either<AuthFailure, Map<String, dynamic>?>> getUserAccessTokenInfo(
    String? accessToken,
  ) async {
    try {
      final response = await dio.get(
        '${googleAuthServiceData.tokeninfo}=$accessToken',
      );
      final tokenInfo = response.data as Map<String, dynamic>;
      logger.d(tokenInfo);

      if (response.statusCode == 200) {
        return Right(tokenInfo);
      } else {
        return Left(_responseToFailure(response));
      }
    } catch (e) {
      logger.d(e);
      return Left(AuthFailure.remote(message: e.toString()));
    }
  }

  Future<Either<AuthFailure, Map<String, dynamic>>> getDateOfBirthd() async {
    try {
      final headers = await googleSignIn.currentUser?.authHeaders;
      final response = await dio.get(
        googleAuthServiceData.peopleInfo,
        options: Options(
          headers: {
            "Authorization": headers?["Authorization"],
          },
        ),
      );

      final birthdays = response.data['birthdays'] as List<dynamic>;
      final dateOfBirthd = birthdays.first["date"] as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return Right(dateOfBirthd);
      } else {
        return Left(_responseToFailure(response));
      }
    } catch (e) {
      logger.d(e);
      return Left(AuthFailure.remote(message: e.toString()));
    }
  }

  Future<Either<AuthFailure, LoginGoogleDataModel>?>
      getAllLoginGoogleData() async {
    try {
      // when user are signed in, it will return tokens of sighned in user.
      // signOut --> rebuild app --> signIn. in this way it will be wokr correctly on both OS.

      try {
        await googleSignIn.signOut();
      } catch (e) {
        logger.d(e);
      }

      final gAccount = await googleSignIn.signIn();
      final gAuth = await gAccount?.authentication;
      final userTokenInfo = await getUserAccessTokenInfo(gAuth?.accessToken);

      return userTokenInfo.fold(
        (l) => Left(l),
        (r) async {
          final userbirthday = await getDateOfBirthd();
          return userbirthday.fold(
            (l) => Left(l),
            (r) async {
              final dob = '${r['year']}-${r['month']}-${r['day']}';
              final parsedDate = DateFormat("yyyy-MM-dd").parse(dob);
              final formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
              logger.d('FORMATED DATE: $formattedDate');

              final jsonModel = LoginGoogleDataModel(
                email: gAccount?.email,
                googleId: googleAuthServiceData.googleId,
                fullName: gAccount?.displayName,
                dateOfBirth: formattedDate,
              ).toJson();

              final loginGoogleDataModel =
                  LoginGoogleDataModel.fromJson(jsonModel);
              logger.d(loginGoogleDataModel.toJson());
              return Right(loginGoogleDataModel);
            },
          );
        },
      );
    } catch (error) {
      return const Left(AuthFailure.local(message: 'Something went wrong'));
    }
  }

  Future<Either<AuthFailure, UserTokensModel>> signInWithGoogleCredentials(
    LoginGoogleDataModel loginGoogleDataModel,
  ) async {
    try {
      final dio = getIt.get<Dio>();
      final response = await dio.post(
        authServiceData.googleSignIn,
        data: loginGoogleDataModel.toJson(),
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
        return Left(AuthFailure.remote(
          message: 'Invalid response',
          code: response.statusCode,
        ));
      }
    } on DioError catch (e) {
      logger.d(e.stackTrace.toString());
      return Left(AuthFailure.local(message: e.message));
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something Wrong'));
    }
  }

  Future<Either<AuthFailure, GoogleSignInAccount?>> signOut() async {
    try {
      final gsignOut = await googleSignIn.signOut();
      return Right(gsignOut);
    } catch (e) {
      logger.d(e);
      return const Left(AuthFailure.local(message: 'Something Wrong'));
    }
  }
}
