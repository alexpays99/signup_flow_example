import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/feed/domain/entity/post/post_creation_entity.dart';
import 'package:login/features/social_network_functionality/data/models/image_model.dart';
import 'package:login/features/feed/domain/entity/post/post_creation_entity.dart';
import 'package:login/features/social_network_functionality/data/models/image_model.dart';

part 'post_creation_model.freezed.dart';

part 'post_creation_model.g.dart';

@freezed
class PostCreationModel with _$PostCreationModel {
  const PostCreationModel._();

  const factory PostCreationModel(
      {required String description,
      required List<ImageModel> source,
      required List<String?> hashtagsNames}) = _PostCreationModel;

  factory PostCreationModel.fromEntity(PostCreationEntity entity) {
    final regExp = RegExp("#[a-zA-Z0-9_]+");
    final hashtags = regExp
        .allMatches(entity.description)
        .map((e) => e.group(0)?.substring(1))
        .toList();
    final images = entity.source.map((e) => ImageModel.fromEntity(e)).toList();
    return PostCreationModel(
      description: entity.description,
      source: images,
      hashtagsNames: hashtags,
    );
  }

  factory PostCreationModel.fromJson(Map<String, dynamic> json) =>
      _$PostCreationModelFromJson(json);
}
