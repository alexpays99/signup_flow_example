import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/core/keys/auth_service_data.dart';
import 'package:login/core/servises/main_service.dart';
import 'package:login/core/servises/main_service_data.dart';
import 'package:login/features/auth/data/repository/auth_repository_impl.dart';
import 'package:login/features/auth/data/repository/user_repository_impl.dart';
import 'package:login/features/auth/domain/repository/auth_repository.dart';
import 'package:login/features/auth/domain/repository/user_repository.dart';
import 'package:login/features/auth/domain/usecases/login_with_credentials.dart';
import 'package:login/features/auth/domain/usecases/login_with_facebook.dart';
import 'package:login/features/auth/domain/usecases/login_with_google_credentials.dart';
import 'package:login/features/auth/domain/usecases/request_confirmation_code.dart';
import 'package:login/features/auth/domain/usecases/reset_password.dart';
import 'package:login/features/auth/domain/usecases/send_confirmation_code.dart';
import 'package:login/features/auth/domain/usecases/sign_out.dart';
import 'package:login/features/auth/domain/usecases/sign_up.dart';
import 'package:login/features/auth/domain/usecases/validate_user_phone.dart';
import 'package:login/features/auth/sevices/google_auth_service.dart';
import 'package:login/features/auth/sevices/timeout_service/timout_service.dart';
import 'package:login/features/auth/sevices/user_storage_service.dart';
import 'package:login/features/social_network_functionality/data/repository/post_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/auth/domain/usecases/validate_user_email.dart';
import '../features/social_network_functionality/domain/usecases/create_post.dart';
import '../features/social_network_functionality/domain/usecases/get_all_user_posts.dart';
import '../features/social_network_functionality/domain/usecases/get_current_user_info.dart';
import '../features/social_network_functionality/domain/usecases/update_user_profile_info.dart';
import '../features/feed/domain/repository/post_repository.dart';
import '../firebase_options.dart';
import '../navigation/app_router.gr.dart';
import '../features/auth/sevices/auth_service.dart';
import 'keys/google_auth_service_data.dart';

GetIt getIt = GetIt.instance;

abstract class InjectionContainer {
  static void initDependencyInjection() async {
    getIt.registerSingleton<AppRouter>(AppRouter());
    getIt.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
            receiveTimeout: 5000,
            sendTimeout: 5000,
            validateStatus: (code) {
              if (code != null) {
                return code < 500;
              } else {
                return false;
              }
            }),
      ),
    );
    getIt.registerSingleton<AuthService>(
      AuthService(
        dio: getIt.get<Dio>(),
        authServiceData: AuthServiceData(),
      ),
    );
    getIt.registerSingleton<MainService>(
      MainService(
        data: MainServiceData(),
        dio: getIt.get<Dio>(),
      ),
    );

    getIt.registerLazySingleton<GoogleSignIn>(
      () => GoogleSignIn(
        scopes: GoogleAuthServiceData().scopes.map((e) => e).toList(),
        clientId: Platform.isIOS
            ? DefaultFirebaseOptions.currentPlatform.iosClientId
            : DefaultFirebaseOptions.currentPlatform.androidClientId,
      ),
    );

    getIt.registerSingleton<GoogleAuthService>(
      GoogleAuthService(
        dio: getIt.get<Dio>(),
        authServiceData: AuthServiceData(),
        googleAuthServiceData: GoogleAuthServiceData(),
        googleSignIn: getIt.get<GoogleSignIn>(),
      ),
    );

    getIt.registerLazySingleton<TimeoutService>(
      () => TimeoutService(
        getIt.get<SharedPreferences>(),
      ),
    );
    getIt.registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);
    getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    );
    getIt.registerSingleton<UserStorageService>(
      UserStorageService(
        storage: getIt.get<FlutterSecureStorage>(),
      ),
    );
    getIt.registerSingleton<UserRepository>(
      UserRepositoryImpl(
        userStorage: getIt.get<UserStorageService>(),
        mainService: getIt.get<MainService>(),
      ),
    );
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        userStorage: getIt.get<UserStorageService>(),
        authService: getIt.get<AuthService>(),
        timeoutService: getIt.get<TimeoutService>(),
        facebookAuth: getIt.get<FacebookAuth>(),
        googleAuthService: getIt.get<GoogleAuthService>(),
      ),
    );
    getIt.registerSingleton<PostRepository>(
      PostRepositoryImpl(
        userStorage: getIt.get<UserStorageService>(),
        mainService: getIt.get<MainService>(),
      ),
    );

    ///USE CASES
    getIt.registerLazySingleton<LoginWithGoogleCredentials>(
      () {
        return LoginWithGoogleCredentials(
          authRepository: getIt.get<AuthRepository>(),
          userRepository: getIt.get<UserRepository>(),
        );
      },
    );
    getIt.registerLazySingleton<LoginWithCredentials>(
      () {
        return LoginWithCredentials(
          authRepository: getIt.get<AuthRepository>(),
          userRepository: getIt.get<UserRepository>(),
        );
      },
    );
    getIt.registerLazySingleton<RequestConfirmationCode>(
      () {
        return RequestConfirmationCode(
            authRepository: getIt.get<AuthRepository>());
      },
    );
    getIt.registerLazySingleton<SendConfirmationCode>(
      () {
        return SendConfirmationCode(
            authRepository: getIt.get<AuthRepository>());
      },
    );
    getIt.registerLazySingleton<SignUp>(
      () {
        return SignUp(
          authRepository: getIt.get<AuthRepository>(),
          userRepository: getIt.get<UserRepository>(),
        );
      },
    );
    getIt.registerLazySingleton<LoginWithFacebook>(
      () {
        return LoginWithFacebook(
          authRepository: getIt.get<AuthRepository>(),
        );
      },
    );
    getIt.registerLazySingleton<SignOut>(
      () {
        return SignOut(
          authRepository: getIt.get<AuthRepository>(),
          userRepository: getIt.get<UserRepository>(),
        );
      },
    );
    getIt.registerLazySingleton<ValidateUserEmail>(
      () {
        return ValidateUserEmail(
          authRepository: getIt.get<AuthRepository>(),
        );
      },
    );
    getIt.registerLazySingleton<ValidateUserPhone>(
      () {
        return ValidateUserPhone(
          authRepository: getIt.get<AuthRepository>(),
        );
      },
    );
    getIt.registerLazySingleton<ResetPassword>(
      () {
        return ResetPassword(
          authRepository: getIt.get<AuthRepository>(),
        );
      },
    );
    getIt.registerLazySingleton<UpdateUserProfileInfo>(() {
      return UpdateUserProfileInfo(
        userRepository: getIt.get<UserRepository>(),
      );
    });
    getIt.registerLazySingleton<GetAllUserPosts>(() {
      return GetAllUserPosts(
        userRepository: getIt.get<UserRepository>(),
        postRepository: getIt.get<PostRepository>(),
      );
    });
    getIt.registerLazySingleton<GetCurrentUserInfo>(() {
      return GetCurrentUserInfo(
        userRepository: getIt.get<UserRepository>(),
      );
    });
    getIt.registerLazySingleton<CreatePost>(() {
      return CreatePost(
        postRepository: getIt.get<PostRepository>(),
      );
    });
  }
}
