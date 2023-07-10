import 'package:app_settings/app_settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../translations/locale_keys.g.dart';

import '../../utils/styles/colors.dart';
import '../gallery_picker/take_photo_from_gallery.dart';
import '../widgets/take_photo_with_camera.dart';

enum PhotoSelectionType {
  camera,
  gallery,
}

class TakePhotoScreen extends StatefulWidget {
  final String appBarTitle;
  final String photoSelectionTittle;
  final String photoSelectionSubTitle;
  final PermissionStatus permissionStatus;
  final PermissionState permissionState;
  final PhotoSelectionType photoSelectionType;
  final void Function(String imagePath, BuildContext context) onPhotoSelected;
  final bool enableAvatarOverlayEnable;

  const TakePhotoScreen({
    super.key,
    required this.appBarTitle,
    required this.photoSelectionTittle,
    required this.photoSelectionSubTitle,
    required this.permissionStatus,
    required this.permissionState,
    required this.photoSelectionType,
    required this.onPhotoSelected,
    this.enableAvatarOverlayEnable = true,
  });

  @override
  State<TakePhotoScreen> createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);
    print("PERMISSION STATUS: :::::::::::::::${widget.permissionStatus}");

    return Scaffold(
      appBar: widget.permissionState != PermissionState.authorized
          ? AppBar(
              leading: TextButton(
                onPressed: () => context.router.pop(),
                child: Text(LocaleKeys.cancel.tr(),
                    style: style.textTheme.bodyMedium),
              ),
              title: Text(
                widget.appBarTitle,
                style: style.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              actions: [
                widget.photoSelectionType == PhotoSelectionType.gallery
                    ? TextButton(
                        onPressed: () {
                          context.router.pop();
                        },
                        child: Text(
                          LocaleKeys.confirm.tr(),
                          style: style.textTheme.bodyMedium?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: CustomPalette.loginblue,
                          ),
                        ),
                      )
                    : const Text(''),
              ],
            )
          : null,
      body: widget.permissionStatus == PermissionStatus.granted ||
              widget.permissionState == PermissionState.authorized
          ? _PhotoMakerWidget(
              photoSelectionType: widget.photoSelectionType,
              permissionState: widget.permissionState,
              onPhotoSelected: widget.onPhotoSelected,
              enableAvatarOverlayEnable: widget.enableAvatarOverlayEnable,
            )
          : Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.photoSelectionTittle,
                    style: style.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: CustomPalette.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Text(
                      widget.photoSelectionSubTitle,
                      style: style.textTheme.bodySmall?.copyWith(
                        fontSize: 15,
                        color: CustomPalette.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: TextButton(
                      onPressed: () {
                        AppSettings.openAppSettings();
                      },
                      child: Text(
                        LocaleKeys.allowInSettings.tr(),
                        style: style.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CustomPalette.loginblue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _PhotoMakerWidget extends StatelessWidget {
  final PhotoSelectionType photoSelectionType;
  final PermissionState permissionState;
  final void Function(String imagePath, BuildContext context) onPhotoSelected;
  final bool enableAvatarOverlayEnable;

  const _PhotoMakerWidget({
    required this.photoSelectionType,
    required this.permissionState,
    required this.onPhotoSelected,
    required this.enableAvatarOverlayEnable,
  });

  @override
  Widget build(BuildContext context) {
    switch (photoSelectionType) {
      case PhotoSelectionType.camera:
        return TakePhotoWithCamera(
          enableAvatarOverlayEnable: enableAvatarOverlayEnable,
          onPhotoSelected: onPhotoSelected,
        );
      case PhotoSelectionType.gallery:
        return TakePhotoFromGallery(
          permissionState: permissionState,
          isAvatar: enableAvatarOverlayEnable,
          onPhotoSelected: onPhotoSelected,
        );
    }
  }
}
