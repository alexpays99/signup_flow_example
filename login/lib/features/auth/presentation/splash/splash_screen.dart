import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/core/keys/asset_path.dart';
import 'package:login/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:login/features/auth/presentation/bloc/auth_state.dart';
import '../../../../navigation/app_router.gr.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {
        state.mapOrNull(
          loggedIn: (loggedState) {
            context.router.replace(const SocialNetworkBlocProviderRoute());
          },
          loggedOut: (unauthorisedState) {
            context.router.replace(const AuthBlocProviderRoute());
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: 64.0,
            width: 302.0,
            child: SvgPicture.asset(AssetPath.internGram),
          ),
        ),
      ),
    );
  }
}
