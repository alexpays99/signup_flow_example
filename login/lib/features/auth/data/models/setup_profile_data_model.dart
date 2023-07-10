import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/auth/domain/entity/setup_profile_data_entity.dart';

part 'setup_profile_data_model.freezed.dart';

part 'setup_profile_data_model.g.dart';

@freezed
class SetupProfileDataModel with _$SetupProfileDataModel {
  const SetupProfileDataModel._();

  @Assert('fullName != null && nickname != null')
  const factory SetupProfileDataModel({
    String? photo,
    String? fullName,
    String? nickname,
    String? city,
    String? bio,
  }) = _SetupProfileDataModel;

  factory SetupProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$SetupProfileDataModelFromJson(json);

  factory SetupProfileDataModel.fromSetupProfileDataEntity(
          SetupProfileDataEntity setupProfileDataEntity) =>
      SetupProfileDataModel(
        photo: setupProfileDataEntity.photo,
        fullName: setupProfileDataEntity.fullName,
        nickname: setupProfileDataEntity.nickname,
        city: setupProfileDataEntity.city,
        bio: setupProfileDataEntity.bio,
      );

  SetupProfileDataEntity get entity => SetupProfileDataEntity(
        photo: photo,
        fullName: fullName,
        nickname: nickname,
        city: city,
        bio: bio,
      );
}
