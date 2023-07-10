import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/core/screens/camera_cubit/camera_cubit.dart';
import 'package:login/core/screens/gallery_picker/cubit/gallery_cubit.dart';
import 'package:login/features/auth/domain/repository/auth_repository.dart';
import 'package:login/features/auth/domain/repository/user_repository.dart';
import '../features/social_network_functionality/presentation/main_navigation/user/user_cubit.dart';
import 'injection_container.dart';

import '../features/auth/presentation/bloc/auth_bloc.dart';

class GlobalBlocProvider extends StatelessWidget implements AutoRouteWrapper {
  const GlobalBlocProvider({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      //todo insert providers for global blocks here
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            userRepository: getIt.get<UserRepository>(),
            authRepository: getIt.get<AuthRepository>(),
          ),
        ),
        BlocProvider<CameraCubit>(
          create: (BuildContext context) => CameraCubit(),
        ),
        BlocProvider<GalleryCubit>(
          create: (BuildContext context) => GalleryCubit(),
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(
            userRepository: getIt.get<UserRepository>(),
          ),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
