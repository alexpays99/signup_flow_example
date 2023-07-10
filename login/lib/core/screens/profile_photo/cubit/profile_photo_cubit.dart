import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../domain/entity/avarat_validation_entity.dart';

part 'profile_photo_state.dart';
part 'profile_photo_cubit.freezed.dart';

class ProfilePhotoCubit extends Cubit<ProfilePhotoState> {
  ProfilePhotoCubit()
      : super(
          ProfilePhotoState(
            avatarStateEntity: AvatarValidaionEntity(
              avatarVlidationState: AvatarValidaionState.tooLargePhoto,
              message: null,
            ),
          ),
        );

  void checkAvatarValidation(String? imagePath) {
    print('IMAGE_PATH: $imagePath');
    if (imagePath != null && imagePath.isNotEmpty) {
      if (isLargePhoto(imagePath)) {
        emit(
          state.copyWith(
            avatarStateEntity: AvatarValidaionEntity(
              avatarVlidationState: AvatarValidaionState.tooLargePhoto,
              message: LocaleKeys.tooLargePhotoError.tr(),
            ),
          ),
        );
      } else if (!isImageFile(imagePath)) {
        emit(
          state.copyWith(
            avatarStateEntity: AvatarValidaionEntity(
              avatarVlidationState: AvatarValidaionState.incorrectFormat,
              message: LocaleKeys.incorrectFormatError.tr(),
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            avatarStateEntity: AvatarValidaionEntity(
              avatarVlidationState: AvatarValidaionState.hasPhoto,
            ),
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          avatarStateEntity: AvatarValidaionEntity(
            avatarVlidationState: AvatarValidaionState.noPhoto,
          ),
        ),
      );
    }
  }

  Future<PermissionStatus> checkCameraPermissionStatus() async {
    return await Permission.camera.request();
  }

  Future<PermissionState> checkGalleryPermissionStatus() async {
    return await PhotoManager.requestPermissionExtend();
  }

  Future<void> deleteAvatar(String? imagePath) async {
    if (imagePath != null || imagePath != '') {
      try {
        final file = File(imagePath!);
        if (await file.exists()) {
          await file.delete();
          emit(
            state.copyWith(
              avatarStateEntity: AvatarValidaionEntity(
                avatarVlidationState: AvatarValidaionState.noPhoto,
                message: null,
              ),
            ),
          );
        } else {
          print("File does not exist");
        }
      } catch (e) {
        print("Error deleting file: $e");
      }
    }
  }

  bool isLargePhoto(String? path) {
    if (path != null && path != '') {
      final file = File(path);
      final size = file.lengthSync();
      print('SIZE OF AVATAR PHOTO: $size');
      // if size of photo bigger that 30mb, emit too large state
      if (size > 30000000) {
        return true;
      }
    }
    return false;
  }

  // Check image file type
  bool isImageFile(String path) {
    final allowedExtensions = ['.jpg', '.jpeg', '.png'];
    final extension = path.split('.').last.toLowerCase();
    print('EXTENSION: $extension');
    return allowedExtensions.contains('.$extension');
  }
}
