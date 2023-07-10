import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/core/domain/entity/user.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  @Assert('email != null ||phoneNumber != null')
  const factory UserModel({
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
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromUserEntity(UserEntity userEntity) => UserModel(
        id: userEntity.id,
        email: userEntity.email,
        phoneNumber: userEntity.phoneNumber,
        fullName: userEntity.fullName,
        nickname: userEntity.nickname,
        dateOfBirth: userEntity.dateOfBirth,
        photo: userEntity.photo,
        city: userEntity.city,
        bio: userEntity.bio,
        createdAt: userEntity.createdAt,
        updatedAt: userEntity.updatedAt,
        followed: userEntity.followed,
        // count: userEntity.count ,
      );

  UserEntity get entity => UserEntity(
        id: id,
        email: email,
        phoneNumber: phoneNumber,
        fullName: fullName,
        nickname: nickname,
        dateOfBirth: dateOfBirth,
        photo: photo,
        city: city,
        bio: bio,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
