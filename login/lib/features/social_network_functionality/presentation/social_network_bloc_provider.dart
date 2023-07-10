import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/social_network_functionality/presentation/feed/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:login/features/social_network_functionality/presentation/create_post/cubit/create_post_cubit.dart';
import 'package:login/features/social_network_functionality/presentation/feed/user_page/cubit/user_page_cubit.dart';

import '../../../core/injection_container.dart';
import '../../../navigation/app_router.gr.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
import '../../auth/presentation/bloc/auth_state.dart';
import '../domain/usecases/create_post.dart';
import 'feed/cubit/feed_cubit.dart';

class SocialNetworkBlocProvider extends StatelessWidget
    implements AutoRouteWrapper {
  const SocialNetworkBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedCubit>(
          create: (BuildContext context) => FeedCubit(),
        ),
        BlocProvider<UserPageCubit>(
          create: (BuildContext context) => UserPageCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => CreatePostCubit(
            createPost: getIt.get<CreatePost>(),
          ),
        ),
        BlocProvider<EditProfileCubit>(
          create: (BuildContext context) => EditProfileCubit(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.mapOrNull(
            loggedOut: (loggedOut) {
              context.router.replaceAll(const [AuthBlocProviderRoute()]);
            },
          );
        },
        child: this,
      ),
    );
  }
}
