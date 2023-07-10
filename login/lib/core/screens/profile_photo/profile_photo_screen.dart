import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:login/core/domain/entity/avarat_validation_entity.dart';
import 'package:login/core/screens/take_photo/take_photo_screen.dart';
import 'package:login/features/auth/domain/entity/button_state_model.dart';
import 'package:login/navigation/app_router.gr.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../core/widgets/primary_button.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../features/auth/domain/entity/setup_profile_data_entity.dart';
import '../../utils/styles/colors.dart';
import 'cubit/profile_photo_cubit.dart';

class ProfilePhotoScreen extends StatefulWidget {
  final String? imagePath;

  const ProfilePhotoScreen({
    super.key,
    this.imagePath = '',
  }) : super();

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  final SetupProfileDataEntity setupProfileDataEntity =
      const SetupProfileDataEntity();

  late ProfilePhotoCubit cubit;
  late ThemeData style;
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  PermissionState _galleryPermissionState = PermissionState.denied;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProfilePhotoCubit>();
    cubit.checkAvatarValidation(widget.imagePath);
    cubit.isLargePhoto(widget.imagePath);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    style = Theme.of(context);
  }

  ImageProvider<Object>? _getImage() {
    if (widget.imagePath != null) {
      return Image.file(
        File(widget.imagePath!),
        fit: BoxFit.cover,
      ).image;
    }
    return null;
  }

  void _showImagePickerBottomSheet(BuildContext context) {
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
            _permissionStatus = await cubit.checkCameraPermissionStatus();
            print(
                "CAMERA PERMISSION STATUS: :::::::::::::::$_permissionStatus");
            context.router.push(
              TakePhotoScreenRoute(
                appBarTitle: LocaleKeys.photo.tr(),
                photoSelectionTittle: LocaleKeys.accessToCameraTitle.tr(),
                photoSelectionSubTitle: LocaleKeys.accessToCameraSubtitle.tr(),
                permissionStatus: _permissionStatus == PermissionStatus.granted
                    ? PermissionStatus.granted
                    : PermissionStatus.denied,
                permissionState:
                    _galleryPermissionState == PermissionState.authorized
                        ? PermissionState.authorized
                        : PermissionState.denied,
                photoSelectionType: PhotoSelectionType.camera,
                onPhotoSelected: (image, context) {
                  context.router.replace(
                    AuthBlocProviderRoute(children: [
                      ProfilePhotoScreenRoute(imagePath: image),
                    ]),
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
            print(
                "GALLERY PERMISSION STATUS: :::::::::::::::$_galleryPermissionState");
            context.router.push(
              TakePhotoScreenRoute(
                  appBarTitle: LocaleKeys.library.tr(),
                  photoSelectionTittle: LocaleKeys.accessToLibraryTitle.tr(),
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
                    context.router.replace(
                      AuthBlocProviderRoute(children: [
                        ProfilePhotoScreenRoute(imagePath: image),
                      ]),
                    );
                  }),
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
  }

  @override
  Widget build(BuildContext context) {
    print("SETUPDUSERPROFILEDATAMODEL: $setupProfileDataEntity");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.profilePhotoTitle.tr(),
              style: style.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: CustomPalette.black,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                LocaleKeys.profilePhotoSubtitle.tr(),
                style: style.textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  color: CustomPalette.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            BlocBuilder<ProfilePhotoCubit, ProfilePhotoState>(
              builder: (context, state) {
                final avatarState = state.avatarStateEntity;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: CircleAvatar(
                        backgroundColor: avatarState?.avatarVlidationState ==
                                    AvatarValidaionState.tooLargePhoto ||
                                avatarState?.avatarVlidationState ==
                                    AvatarValidaionState.incorrectFormat ||
                                avatarState?.avatarVlidationState ==
                                    AvatarValidaionState.notSuitablePhoto
                            ? CustomPalette.errorRed
                            : CustomPalette.transparent,
                        radius: 61,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: CustomPalette.black10,
                          backgroundImage: avatarState?.avatarVlidationState ==
                                  AvatarValidaionState.hasPhoto
                              ? _getImage()
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        _showImagePickerBottomSheet(context);
                      },
                      child: Text(
                        avatarState?.avatarVlidationState ==
                                    AvatarValidaionState.noPhoto ||
                                avatarState?.avatarVlidationState ==
                                    AvatarValidaionState.tooLargePhoto ||
                                avatarState?.avatarVlidationState ==
                                    AvatarValidaionState.incorrectFormat ||
                                avatarState?.avatarVlidationState ==
                                    AvatarValidaionState.notSuitablePhoto
                            ? LocaleKeys.addPhoto.tr()
                            : LocaleKeys.changePhoto.tr(),
                        style: style.textTheme.bodySmall?.copyWith(
                          color: CustomPalette.darkBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: avatarState?.avatarVlidationState ==
                                  AvatarValidaionState.noPhoto ||
                              avatarState?.avatarVlidationState ==
                                  AvatarValidaionState.tooLargePhoto ||
                              avatarState?.avatarVlidationState ==
                                  AvatarValidaionState.incorrectFormat ||
                              avatarState?.avatarVlidationState ==
                                  AvatarValidaionState.notSuitablePhoto
                          ? Container()
                          : TextButton(
                              onPressed: () async {
                                await cubit.deleteAvatar(widget.imagePath);
                              },
                              child: Text(
                                LocaleKeys.deletePhoto.tr(),
                                style: style.textTheme.bodySmall?.copyWith(
                                  color: CustomPalette.errorRed,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: avatarState?.avatarVlidationState ==
                                  AvatarValidaionState.tooLargePhoto ||
                              avatarState?.avatarVlidationState ==
                                  AvatarValidaionState.incorrectFormat ||
                              avatarState?.avatarVlidationState ==
                                  AvatarValidaionState.notSuitablePhoto
                          ? Text(
                              avatarState?.message ?? '',
                              style: style.textTheme.titleSmall?.copyWith(
                                color: CustomPalette.errorRed,
                              ),
                            )
                          : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: PrimaryButton(
                        state: ButtonState.active,
                        text: LocaleKeys.next.tr(),
                        onPress: () {
                          context.router.pushAll(
                            [
                              EnterCityScreenRoute(
                                setupProfileDataEntity:
                                    setupProfileDataEntity.copyWith(
                                  photo: widget.imagePath,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
