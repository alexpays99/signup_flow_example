import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/feed/domain/entity/post/post_entity.dart';

import 'count.dart';

part 'post_model.freezed.dart';

part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  const PostModel._();

  const factory PostModel({
    String? id,
    List<String>? source,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: '_count') Count? count,
    bool? liked,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  factory PostModel.fromEntity(PostEntity entity) => PostModel(
        id: entity.id,
        source: entity.source,
        description: entity.description,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        userId: entity.userId,
        count: Count(likes: entity.likes),
        liked: entity.liked,
      );

  PostEntity get entity => PostEntity(
        id: id,
        source: source,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
        userId: userId,
        likes: count?.likes ?? 0,
        liked: liked,
      );
}
