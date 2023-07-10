import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cropperx/cropperx.dart';
import 'package:login/core/screens/camera_cubit/camera_cubit.dart';

import '../../../translations/locale_keys.g.dart';
import '../../utils/styles/colors.dart';

class ImageCroppingScreen extends StatefulWidget {
  final String imagePaht;
  final void Function(String imagePath, BuildContext context) onPhotoSelected;
  final bool enableAvatarOverlayEnable;

  const ImageCroppingScreen({
    super.key,
    required this.imagePaht,
    required this.onPhotoSelected,
    required this.enableAvatarOverlayEnable,
  });

  @override
  State<ImageCroppingScreen> createState() => _ImageCroppingScreenState();
}

class _ImageCroppingScreenState extends State<ImageCroppingScreen> {
  // Key for the boundary of the image to be cropped
  final _boundaryKey = GlobalKey(debugLabel: 'cameraCropperKey');
  late CameraCubit cubit;
  late File? _imageFile;
  late ThemeData style;
  late Size size;

  @override
  void initState() {
    super.initState();
    _imageFile = File(widget.imagePaht);
    cubit = context.read<CameraCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    style = Theme.of(context);
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => context.router.pop(),
          child: Text(
            LocaleKeys.cancel.tr(),
            style: style.textTheme.bodyMedium,
          ),
        ),
        title: Center(
          child: Text(
            LocaleKeys.photo.tr(),
            style: style.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final imageBytes = await Cropper.crop(cropperKey: _boundaryKey);
              cubit.cropImage(imageBytes: imageBytes).then((value) {
                widget.onPhotoSelected(value?.path ?? '', context);
              });
            },
            child: Text(
              LocaleKeys.confirm.tr(),
              style: style.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: CustomPalette.loginblue,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: _imageFile != null
                ? Cropper(
                    zoomScale: 10.0,
                    overlayType: widget.enableAvatarOverlayEnable
                        ? OverlayType.circle
                        : OverlayType.none,
                    overlayColor: CustomPalette.pikersAvatarOverlay,
                    cropperKey: _boundaryKey,
                    image: Image.file(_imageFile!),
                  )
                : Container(),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
