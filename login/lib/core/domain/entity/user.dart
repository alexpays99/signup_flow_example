import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/core/domain/entity/count.dart';

part 'user.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  @Assert('email != null ||phoneNumber != null')
  const factory UserEntity({
    required String id,
    String? email,
    String? phoneNumber,
    required String fullName,
    required String nickname,
    required String dateOfBirth,
    @Default('') String photo,
    @Default('') String city,
    @Default('') String bio,
    @Default('') String createdAt,
    @Default('') String updatedAt,
    @Default(false) bool followed,
    @JsonKey(name: '_count') Count? count,
  }) = _UserEntity;
}
