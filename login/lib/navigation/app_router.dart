import 'package:auto_route/annotations.dart';
import 'package:login/core/global_bloc_provider.dart';
import 'package:login/core/screens/image_cropping/image_cropping_screen.dart';
import 'package:login/core/screens/profile_photo/profile_photo_screen.dart';
import 'package:login/core/screens/take_photo/take_photo_screen.dart';
import 'package:login/features/auth/presentation/add_bio/add_bio_screen.dart';
import 'package:login/features/auth/presentation/add_full_name/add_full_name_screen.dart';
import 'package:login/features/auth/presentation/auth_bloc_provider.dart';
import 'package:login/features/auth/presentation/create_nickname/create_nickname_screen.dart';
import 'package:login/features/auth/presentation/create_password/create_password_screen.dart';
import 'package:login/features/auth/presentation/enter_birthday/enter_birthday_screen.dart';
import 'package:login/features/auth/presentation/enter_city/enter_city_screen.dart';
import 'package:login/features/auth/presentation/login/login_screen.dart';

import '../features/auth/presentation/create_password/password_recovery_screen.dart';
import '../features/auth/presentation/phone_or_email/phone_or_email_screen.dart';
import '../features/auth/presentation/phone_or_email/recovery_phone_or_email.dart';
import '../features/auth/presentation/splash/splash_screen.dart';
import '../features/auth/presentation/terms_and_conditions/terms_and_conditions_screen.dart';
import '../features/social_network_functionality/presentation/feed/user_page/user_page.dart';
import 'route_paths.dart';

@MaterialAutoRouter(routes: [
  AdaptiveRoute(
    initial: true,
    path: RoutePaths.myApp,
    page: GlobalBlocProvider,
    children: [
      AdaptiveRoute(
        initial: true,
        path: RoutePaths.splash,
        page: SplashScreen,
      ),
      AdaptiveRoute(
        path: RoutePaths.auth,
        page: AuthBlocProvider,
        children: [
          AdaptiveRoute(
            initial: true,
            page: LoginScreen,
            path: RoutePaths.login,
          ),
          AdaptiveRoute(
            page: TermsAndConditionsScreen,
            path: RoutePaths.termsAndConditions,
          ),
          AdaptiveRoute(
              path: RoutePaths.phoneOrEmail, page: PhoneOrEmailScreen),
          AdaptiveRoute(
              path: RoutePaths.createPassword, page: CreatePasswordScreen),
          AdaptiveRoute(
              path: RoutePaths.createNickname, page: CreateNicknameScreen),
          AdaptiveRoute(path: RoutePaths.addFullName, page: AddFullNameScreen),
          AdaptiveRoute(
              path: RoutePaths.enterBirthday, page: EnterBirthdayScreen),
          AdaptiveRoute(
            path: RoutePaths.photoSelectionScreen,
            page: ProfilePhotoScreen,
          ),
          AdaptiveRoute(path: RoutePaths.enterCity, page: EnterCityScreen),
          AdaptiveRoute(path: RoutePaths.addBio, page: AddBioScreen),
          AdaptiveRoute(
            path: RoutePaths.passwordRecoveryEmailOrPhone,
            page: PasswordRecoveryPhoneOrEmailScreen,
          ),
          AdaptiveRoute(
            path: RoutePaths.passwordRecoveryPassword,
            page: PasswordRecoveryPasswordScreen,
          ),
        ],
      ),
      AdaptiveRoute(
        path: RoutePaths.takePhotoScreen,
        page: TakePhotoScreen,
      ),
      AdaptiveRoute(
        path: RoutePaths.imageCropperScreen,
        page: ImageCroppingScreen,
      ),
      AdaptiveRoute(
        path: RoutePaths.userPage,
        page: UserPage,
      ),
      // AdaptiveRoute(
      //   page: SocialNetworkBlocProvider,
      //   path: RoutePaths.socialNetwork,
      //   children: [
      //     AdaptiveRoute(
      //       initial: true,
      //       path: RoutePaths.socialTabNavigation,
      //       page: MainNavigationPage,
      //       children: [
      //         AdaptiveRoute(
      //           // initial: true,
      //           path: RoutePaths.feed,
      //           page: FeedScreen,
      //         ),
      //         AdaptiveRoute(
      //           path: RoutePaths.search,
      //           page: SearchMock,
      //         ),
      //         AdaptiveRoute(
      //           path: 'create_post_mock',
      //           page: CreatePostMock,
      //         ),
      //         AdaptiveRoute(
      //           path: RoutePaths.liked,
      //           page: LikedPostMock,
      //         ),
      //         AdaptiveRoute(
      //           initial: true,
      //           path: RoutePaths.userPage,
      //           page: UserPage,
      //         ),
      //       ],
      //     ),
      //     AdaptiveRoute(
      //       page: CreatePostPage,
      //       path: RoutePaths.createPost,
      //     ),
      //     AdaptiveRoute(
      //       path: RoutePaths.editProfile,
      //       page: EditProfileScreen,
      //     ),
      //     AdaptiveRoute(
      //       path: RoutePaths.postInfo,
      //       page: PostInfo,
      //     ),
      //   ],
      // )
    ],
  )
])
class $AppRouter {}
