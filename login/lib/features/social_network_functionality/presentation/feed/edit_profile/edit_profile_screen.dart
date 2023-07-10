import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../../core/domain/entity/user.dart';
import '../../../../../core/screens/profile_photo/cubit/profile_photo_cubit.dart';
import '../../../../../core/screens/take_photo/take_photo_screen.dart';
import '../../../../../core/utils/styles/colors.dart';
import '../../../../../core/widgets/common_user_data.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../../navigation/app_router.gr.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../auth/domain/entity/button_state_model.dart';
import '../../../../auth/domain/entity/field_verifiable_model.dart';
import 'cubit/edit_profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  final UserEntity? user;
  const EditProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late EditProfileCubit cubit;
  late ProfilePhotoCubit profilePhotocubit;

  ///TEMP mock
  var _permissionStatus = PermissionStatus.denied;
  var _galleryPermissionState = PermissionState.denied;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<EditProfileCubit>(context);
    profilePhotocubit = ProfilePhotoCubit();
    cubit.setImage(widget.user?.photo);
    cubit.setInitialValues(
      widget.user?.fullName,
      widget.user?.nickname,
      widget.user?.city,
      widget.user?.bio,
    );
  }

  Icon _getSuffixIcon(FieldVerifiableModel<dynamic>? textField) {
    IconData iconData = Icons.close;
    Color iconColor = Colors.black;
    double iconSize = 15.0;

    switch (textField?.validationState) {
      case ValidationState.unknown:
        break;
      case ValidationState.valid:
        iconData = Icons.check;
        iconColor = CustomPalette.successGreen;
        break;
      case ValidationState.invalid:
        iconData = Icons.close;
        iconColor = CustomPalette.errorRed;
        break;
      default:
        break;
    }

    return Icon(
      iconData,
      color: iconColor,
      size: iconSize,
    );
  }

  Color _getSuffixColor(FieldVerifiableModel<dynamic>? textField) {
    switch (textField?.validationState) {
      case ValidationState.unknown:
        return CustomPalette.black45;
      case ValidationState.valid:
        return CustomPalette.successGreen;
      case ValidationState.invalid:
        return CustomPalette.errorRed;
      default:
        return CustomPalette.black45;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: Text(
                  LocaleKeys.editCancel_title.tr(),
                  style: style.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () {
                      context.router.pop();
                    },
                    child: Text(LocaleKeys.cancel.tr()),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      context.router.pop();
                      context.router.navigate(const MainNavigationPageRoute());
                    },
                    isDestructiveAction: true,
                    child: Text(
                      LocaleKeys.editCancel_leavePage.tr(),
                    ),
                  ),
                ],
              ),
            );
          },
          child:
              Text(LocaleKeys.cancel.tr(), style: style.textTheme.bodyMedium),
        ),
        centerTitle: true,
        title: Text(
          LocaleKeys.edit.tr(),
          style: style.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<EditProfileCubit, EditProfileState>(
          bloc: cubit,
          listener: (context, state) {
            if (state.isUSerUpdated) {
              context.router.pop();
            }
          },
          builder: (context, state) {
            final image = state.photo;
            final fullName = state.fullName;
            final nickname = state.nickname;
            final city = state.city;
            final bio = state.bio;
            final saveChanges = state.saveChangesButton;

            return Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: image != null &&
                            image.isNotEmpty &&
                            !image.startsWith('http') &&
                            !image.startsWith(
                                'file://') // add check for file path URI
                        ? Image.file(File(image)).image
                        : NetworkImage(image ?? ''),
                    backgroundColor: image == null ||
                            image.isEmpty ||
                            image.startsWith(
                                'file://') // add check for file path URI
                        ? CustomPalette
                            .black10 // Set grey color when image is null or empty or when image is a file path URI
                        : Colors
                            .transparent, // Set transparent when image is not null or empty and not a file path URI
                    child: image == null || image.isEmpty
                        ? const Icon(
                            Icons.person,
                            size: 60,
                            color: CustomPalette.black45,
                          ) // Display an icon or text in the center
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
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
                              _permissionStatus = await profilePhotocubit
                                  .checkCameraPermissionStatus();
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
                                    cubit.setImage(image);
                                    print('SET PHTOTO FROM ROUPE: $image');
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
                              _galleryPermissionState = await profilePhotocubit
                                  .checkGalleryPermissionStatus();
                              context.router.pop();
                              context.router.push(
                                TakePhotoScreenRoute(
                                  appBarTitle: LocaleKeys.library.tr(),
                                  photoSelectionTittle:
                                      LocaleKeys.accessToLibraryTitle.tr(),
                                  photoSelectionSubTitle:
                                      LocaleKeys.accessToLibrarySubtitle.tr(),
                                  permissionStatus:
                                      _galleryPermissionState.isAuth
                                          ? PermissionStatus.granted
                                          : PermissionStatus.denied,
                                  permissionState:
                                      _galleryPermissionState.isAuth
                                          ? PermissionState.authorized
                                          : PermissionState.denied,
                                  photoSelectionType:
                                      PhotoSelectionType.gallery,
                                  onPhotoSelected: (image, context) {
                                    context.router.popUntilRoot();
                                    cubit.setImage(image);
                                  },
                                ),
                              );
                            },
                          ),
                          BottomSheetAction(
                            title: Text(
                              LocaleKeys.deletePhoto.tr(),
                              style: style.textTheme.bodyLarge?.copyWith(
                                color: CustomPalette.errorRed,
                                fontSize: 15,
                              ),
                            ),
                            onPressed: (context) async {
                              await cubit.deleteAvatar().then(
                                  (value) => context.router.popUntilRoot());
                            },
                          ),
                        ],
                        cancelAction: CancelAction(
                          title: Text(
                            LocaleKeys.cancel.tr(),
                            style: style.textTheme.bodyLarge?.copyWith(
                              color: CustomPalette.blue,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      LocaleKeys.changePhoto.tr(),
                      style: style.textTheme.bodySmall?.copyWith(
                        color: CustomPalette.darkBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.fullName.tr(),
                        style: style.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonUserData(
                        initialText: widget.user?.fullName,
                        suffixIcon: _getSuffixIcon(fullName),
                        suffixColor: _getSuffixColor(fullName),
                        hintText: LocaleKeys.fullName.tr(),
                        errorText: fullName?.message,
                        onChanged: (inputData) {
                          cubit.fullNameInput(inputData);
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        LocaleKeys.nickname.tr(),
                        style: style.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonUserData(
                        initialText: widget.user?.nickname,
                        suffixIcon: _getSuffixIcon(nickname),
                        suffixColor: _getSuffixColor(nickname),
                        hintText: LocaleKeys.nickname.tr(),
                        errorText: nickname?.message,
                        onChanged: (inputData) {
                          cubit.nicknameInput(inputData);
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        LocaleKeys.yourCity.tr(),
                        style: style.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonUserData(
                        initialText: widget.user?.city,
                        suffixIcon: _getSuffixIcon(city),
                        suffixColor: _getSuffixColor(city),
                        hintText: LocaleKeys.yourCity.tr(),
                        errorText: city?.message,
                        onChanged: (inputData) {
                          cubit.cityInput(inputData);
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        LocaleKeys.bio.tr(),
                        style: style.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CommonUserData(
                        initialText: widget.user?.bio,
                        suffixIcon: _getSuffixIcon(bio),
                        suffixColor: _getSuffixColor(bio),
                        hintText: LocaleKeys.bio.tr(),
                        errorText: bio?.message,
                        maxLength: 120,
                        maxLines: 7,
                        onChanged: (inputData) {
                          cubit.bioInput(inputData);
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 80),
                    child: PrimaryButton(
                      state: saveChanges ?? ButtonState.inactive,
                      text: LocaleKeys.saveChanges.tr(),
                      onPress: () async {
                        await cubit.saveChanges();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
