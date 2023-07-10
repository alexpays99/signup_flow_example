import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/core/domain/entity/user.dart';
import 'package:login/core/widgets/main_bottom_navigation_bar.dart';
import 'package:login/features/social_network_functionality/presentation/main_navigation/user/user_cubit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../core/screens/profile_photo/cubit/profile_photo_cubit.dart';
import '../../../../core/screens/take_photo/take_photo_screen.dart';
import '../../../../core/utils/styles/colors.dart';
import '../../../../navigation/app_router.gr.dart';
import '../../../../translations/locale_keys.g.dart';

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    ///TEMP mock
    var _permissionStatus = PermissionStatus.denied;
    var _galleryPermissionState = PermissionState.denied;
    final cubit = ProfilePhotoCubit();

    ///end of TEMP mock

    return AutoTabsScaffold(
      routes: const [
        FeedScreenRoute(),
        SearchMockRoute(),
        CreatePostMockRoute(),
        LikedPostMockRoute(),
        UserPageRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BlocBuilder<UserCubit, UserEntity?>(
            bloc: context.read<UserCubit>(),
            builder: (context, state) {
              return MainBottomNavigationBar(
                onTap: (index) {
                  if (index == 2) {
                    showAdaptiveActionSheet(
                      context: context,
                      actions: <BottomSheetAction>[
                        BottomSheetAction(
                          title: Text(
                            LocaleKeys.takePhoto.tr(),
                            style: style.textTheme.bodyLarge?.copyWith(
                              color: CustomPalette.blue,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: (context) async {
                            _permissionStatus =
                                await cubit.checkCameraPermissionStatus();
                            context.router.pop();
                            context.router.push(
                              TakePhotoScreenRoute(
                                appBarTitle: LocaleKeys.photo.tr(),
                                photoSelectionTittle:
                                    LocaleKeys.accessToCameraTitle.tr(),
                                photoSelectionSubTitle:
                                    LocaleKeys.accessToCameraSubtitle.tr(),
                                permissionStatus: _permissionStatus ==
                                        PermissionStatus.granted
                                    ? PermissionStatus.granted
                                    : PermissionStatus.denied,
                                permissionState: _galleryPermissionState ==
                                        PermissionState.authorized
                                    ? PermissionState.authorized
                                    : PermissionState.denied,
                                photoSelectionType: PhotoSelectionType.camera,
                                onPhotoSelected: (image, context) {
                                  context.router.popUntilRoot();
                                  context.router.push(
                                    CreatePostPageRoute(imagePath: image),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        BottomSheetAction(
                          title: Text(
                            LocaleKeys.chooseFromLibrary.tr(),
                            style: style.textTheme.bodyLarge?.copyWith(
                              color: CustomPalette.blue,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: (context) async {
                            _galleryPermissionState =
                                await cubit.checkGalleryPermissionStatus();
                            context.router.pop();
                            context.router.push(
                              TakePhotoScreenRoute(
                                appBarTitle: LocaleKeys.library.tr(),
                                photoSelectionTittle:
                                    LocaleKeys.accessToLibraryTitle.tr(),
                                photoSelectionSubTitle:
                                    LocaleKeys.accessToLibrarySubtitle.tr(),
                                permissionStatus: _galleryPermissionState.isAuth
                                    ? PermissionStatus.granted
                                    : PermissionStatus.denied,
                                permissionState: _galleryPermissionState.isAuth
                                    ? PermissionState.authorized
                                    : PermissionState.denied,
                                photoSelectionType: PhotoSelectionType.gallery,
                                onPhotoSelected: (image, context) {
                                  context.router.popUntilRoot();
                                  context.router.push(
                                    CreatePostPageRoute(imagePath: image),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                      cancelAction: CancelAction(
                        title: Text(
                          LocaleKeys.cancel.tr(),
                          style: style.textTheme.bodyLarge?.copyWith(
                            color: CustomPalette.errorRed,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  } else {
                    tabsRouter.setActiveIndex(index);
                  }
                },
                activeUser: state,
                activeIndex: tabsRouter.activeIndex,
              );
            });
      },
    );
  }
}
