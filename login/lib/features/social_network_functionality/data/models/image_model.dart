import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/feed/domain/entity/post/image_entity.dart';

part 'image_model.freezed.dart';

part 'image_model.g.dart';

@freezed
class ImageModel with _$ImageModel {
  const ImageModel._();

  const factory ImageModel({
    required String base64File,
    required String ext,
  }) = _ImageModel;

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  factory ImageModel.fromEntity(ImageEntity entity) {
    return ImageModel(
      base64File: entity.imageData,
      ext: entity.ext,
    );
  }

  ImageEntity get entity => ImageEntity(
        imageData: base64File,
        ext: ext,
      );
}
