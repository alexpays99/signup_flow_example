import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';

part 'gallery_state.dart';

part 'gallery_cubit.freezed.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryState.initial());

  Future setImage(int index) async {
    emit(state.copyWith(selectedIndex: index));
  }

  // Load all images from gallery device
  Future loadImages(PermissionState result) async {
    if (!result.isAuth) {
      emit(
        state.copyWith(assetsList: []),
      );
    }
    final assets = await PhotoManager.getAssetPathList(type: RequestType.image);
    final imageAssets = await assets[0].getAssetListRange(
      start: 0,
      end: await assets[0].assetCountAsync,
    );
    emit(
      state.copyWith(
        assetsList: imageAssets,
        selectedIndex: imageAssets.isNotEmpty ? 0 : -1,
      ),
    );
  }

  // Function to handle crop image and return image file
  Future<File?> cropImage({Uint8List? imageBytes}) async {
    try {
      if (imageBytes != null) {
        final tempDir = await getTemporaryDirectory();
        File file = await File(
                '${tempDir.path}/${DateTime.now().microsecondsSinceEpoch}temp_image.png')
            .create();
        file.writeAsBytes(imageBytes);
        return file;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
