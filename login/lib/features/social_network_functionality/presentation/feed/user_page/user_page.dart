import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/core/utils/styles/colors.dart';
import 'package:login/features/feed/domain/entity/post/post_entity.dart';
import 'package:login/features/social_network_functionality/presentation/feed/user_page/widgets/current_user_info.dart';
import 'package:login/features/social_network_functionality/presentation/feed/user_page/widgets/posts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;

import '../../../../../core/keys/asset_path.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../../navigation/app_router.gr.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../auth/domain/entity/button_state_model.dart';
import '../../../../feed/data/models/current_user_state_mode.dart';
import '../cubit/feed_cubit.dart';
import 'cubit/user_page_cubit.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late ThemeData style;
  late UserPageCubit cubit;
  late RefreshController _refreshController;
  List<PostEntity> newData = [];

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    cubit = BlocProvider.of<UserPageCubit>(context);
    cubit.fetchCurrentUserInfo();
    _onLoading();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    style = Theme.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  Future<void> _onRefresh() async {
    await cubit.refreshPosts();
    newData = cubit.state.postListStateModel?.value ?? [];
    setState(() {
      newData;
    });
    _refreshController.loadComplete();
  }

  Future<void> _onLoading() async {
    await cubit.fetchAllUserPosts();
    newData += cubit.state.postListStateModel?.value ?? [];
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPageCubit, UserPageState>(
      buildWhen: (previous, current) {
        return previous.currentUserStateModel?.value !=
                current.currentUserStateModel?.value ||
            previous.postListStateModel?.value !=
                current.postListStateModel?.value;
      },
      builder: (context, state) {
        final currentUser = state.currentUserStateModel;
        final nickname =
            currentUser?.currentUserState == CurrentUserState.loaded
                ? currentUser?.value?.nickname
                : '';
        final avatar = currentUser?.currentUserState == CurrentUserState.loaded
            ? currentUser?.value?.photo
            : '';
        final posts = currentUser?.currentUserState == CurrentUserState.loaded
            ? currentUser?.value?.count?.posts.toString()
            : '';
        final followers =
            currentUser?.currentUserState == CurrentUserState.loaded
                ? currentUser?.value?.count?.followers.toString()
                : '';
        final following =
            currentUser?.currentUserState == CurrentUserState.loaded
                ? currentUser?.value?.count?.following.toString()
                : '';
        final fullName =
            currentUser?.currentUserState == CurrentUserState.loaded
                ? currentUser?.value?.fullName
                : '';
        final bio = currentUser?.currentUserState == CurrentUserState.loaded
            ? currentUser?.value?.bio
            : '';
        final city = currentUser?.currentUserState == CurrentUserState.loaded
            ? currentUser?.value?.city
            : '';

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(
                  nickname ?? '',
                  style: style.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: CustomPalette.black,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: InkWell(
                  onTap: () {
                    context.read<FeedCubit>().signout();
                  },
                  child: SvgPicture.asset(
                    AssetPath.message,
                  ),
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await cubit.fetchCurrentUserInfo();
              await _onRefresh();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrentUserInfo(
                    avatar: avatar,
                    posts: posts,
                    style: style,
                    followers: followers,
                    following: following,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      fullName ?? '',
                      style: style.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      bio ?? '',
                      style: style.textTheme.bodySmall?.copyWith(
                        color: CustomPalette.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      city ?? '',
                      style: style.textTheme.bodySmall?.copyWith(
                        color: CustomPalette.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: PrimaryButton(
                      state: ButtonState.active,
                      text: LocaleKeys.edit.tr(),
                      onPress: () async {
                        context.router.push(
                          EditProfileScreenRoute(user: currentUser?.value),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: false,
                        enablePullUp: true,
                        footer: CustomFooter(
                          builder: (BuildContext context, LoadStatus? mode) {
                            Widget body;
                            if (mode == LoadStatus.loading) {
                              body = const CupertinoActivityIndicator();
                            } else if (mode == LoadStatus.failed) {
                              body = Text(LocaleKeys.loadFailed.tr());
                            } else {
                              body = Text(LocaleKeys.noMoreData.tr());
                            }
                            return SizedBox(
                              height: 45.0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        onLoading: () async {
                          await _onLoading();
                        },
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                          itemCount: newData.length,
                          itemBuilder: (context, index) {
                            return PostItem(
                              user: currentUser?.value,
                              post: newData[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
