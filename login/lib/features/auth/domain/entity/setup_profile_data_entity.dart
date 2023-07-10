import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_profile_data_entity.freezed.dart';

@freezed
class SetupProfileDataEntity with _$SetupProfileDataEntity {
  const SetupProfileDataEntity._();

  const factory SetupProfileDataEntity({
    String? photo,
    String? fullName,
    String? nickname,
    String? city,
    String? bio,
  }) = _SetupProfileDataEntity;
}
