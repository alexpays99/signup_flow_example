import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'camera_state.dart';
part 'camera_cubit.freezed.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(const CameraState.initial());

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
