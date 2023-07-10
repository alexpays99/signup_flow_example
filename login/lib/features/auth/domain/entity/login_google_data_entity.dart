import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_google_data_entity.freezed.dart';

@freezed
class LoginGoogleDataEntity with _$LoginGoogleDataEntity {
  @Assert(
      'email != null || googleId != null || fullName != null || dateOfBirth != null')
  const factory LoginGoogleDataEntity({
    String? email,
    String? googleId,
    String? fullName,
    String? dateOfBirth,
  }) = _LoginGoogleDataEntity;
}
