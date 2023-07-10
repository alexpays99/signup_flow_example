import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/feed/domain/entity/post/image_entity.dart';

part 'post_creation_entity.freezed.dart';

@freezed
class PostCreationEntity with _$PostCreationEntity {
  const PostCreationEntity._();

  const factory PostCreationEntity({
    required String description,
    required List<ImageEntity> source,
  }) = _PostCreationEntity;

  factory PostCreationEntity.create(
    String imageData,
    String ext,
    String description,
  ) {
    return PostCreationEntity(
      description: description,
      source: [
        ImageEntity(
          imageData: imageData,
          ext: ext,
        ),
      ],
    );
  }
}
