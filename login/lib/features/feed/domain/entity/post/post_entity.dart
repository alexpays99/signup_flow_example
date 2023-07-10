import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_entity.freezed.dart';

@freezed
class PostEntity with _$PostEntity {
  const factory PostEntity({
    String? id,
    List<String>? source,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    @Default(0) int likes,
    bool? liked,
  }) = _PostEntity;

}
