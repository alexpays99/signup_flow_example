import 'package:auto_route/auto_route.dart';
import 'package:login/features/auth/domain/repository/auth_repository.dart';
import 'package:login/navigation/app_router.gr.dart';

class AuthRouteGuard extends AutoRouteGuard {
  final AuthRepository authRepository;

  AuthRouteGuard({required this.authRepository});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    ///TODO(Hrihoriy) finish redirection
    if (authRepository.state == AuthRepositoryState.signedIn) {
      resolver.next(true);
    } else {
      router.replaceAll([const LoginScreenRoute()]);
    }
  }
}
