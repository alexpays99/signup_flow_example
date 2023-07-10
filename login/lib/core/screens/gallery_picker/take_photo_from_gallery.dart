import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:cropperx/cropperx.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../translations/locale_keys.g.dart';

import '../../utils/styles/colors.dart';
import 'cubit/gallery_cubit.dart';

class TakePhotoFromGallery extends StatefulWidget {
  final PermissionState permissionState;
  final bool isAvatar;
  final void Function(String string, BuildContext context) onPhotoSelected;

  const TakePhotoFromGallery({
    super.key,
    required this.permissionState,
    required this.onPhotoSelected,
    this.isAvatar = true,
  });

  @override
  State<TakePhotoFromGallery> createState() => _TakePhotoFromGalleryState();
}

class _TakePhotoFromGalleryState extends State<TakePhotoFromGallery> {
  late GalleryCubit cubit;
  late Size size;
  late ThemeData style;

  // Key for the boundary of the image to be cropped
  final _boundaryKey = GlobalKey(debugLabel: 'galleryCropperKey');

  @override
  void initState() {
    super.initState();
    cubit = context.read<GalleryCubit>();
    cubit.loadImages(widget.permissionState);
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
          child:
              Text(LocaleKeys.cancel.tr(), style: style.textTheme.bodyMedium),
        ),
        title: Center(
          child: Text(
            LocaleKeys.library.tr(),
            style: style.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final imageBytes = await Cropper.crop(cropperKey: _boundaryKey);
              final value = await cubit.cropImage(imageBytes: imageBytes);
              ///TODO rework context in async method(was there before)
              context.router.pop(
                value?.path ?? '',
              );
              widget.onPhotoSelected(value?.path ?? '', context);
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
          BlocBuilder<GalleryCubit, GalleryState>(
            bloc: cubit,
            buildWhen: (prev, cur) {
              return prev.selectedIndex != cur.selectedIndex;
            },
            builder: (context, state) {
              return state.selectedIndex == -1
                  ? const CupertinoActivityIndicator()
                  : FutureBuilder(
                      future:
                          state.assetsList?[state.selectedIndex].originBytes,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CupertinoActivityIndicator();
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              LocaleKeys.unexpectedError.tr(),
                            ),
                          );
                        }
                        return Cropper(
                          zoomScale: 10.0,
                          overlayType: widget.isAvatar
                              ? OverlayType.circle
                              : OverlayType.none,
                          overlayColor: CustomPalette.pikersAvatarOverlay,
                          cropperKey: _boundaryKey,
                          image: Image.memory(
                            snapshot.data!,
                          ),
                        );
                      },
                    );
            },
          ),
          BlocBuilder<GalleryCubit, GalleryState>(
              bloc: cubit,
              buildWhen: (prev, cur) {
                return prev.assetsList != cur.assetsList;
              },
              builder: (context, state) {
                return Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: state.assetsList?.length,
                    itemBuilder: (context, index) {
                      final data = state.assetsList?[index];

                      return FutureBuilder<Uint8List?>(
                        future: data?.thumbnailData,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          }
                          return InkWell(
                            onTap: () {
                              cubit.setImage(index);
                            },
                            child: Image.memory(
                              snapshot.data!,
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
