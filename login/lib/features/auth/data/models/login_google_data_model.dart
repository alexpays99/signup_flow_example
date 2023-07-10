import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/login_google_data_entity.dart';

part 'login_google_data_model.freezed.dart';

part 'login_google_data_model.g.dart';

@freezed
class LoginGoogleDataModel with _$LoginGoogleDataModel {
  const LoginGoogleDataModel._();

  @Assert(
      'email != null || googleId != null || fullName != null || dateOfBirth != null')
  const factory LoginGoogleDataModel({
    String? email,
    String? googleId,
    String? fullName,
    String? dateOfBirth,
  }) = _LoginGoogleDataModel;

  factory LoginGoogleDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginGoogleDataModelFromJson(json);

  factory LoginGoogleDataModel.fromEntity(LoginGoogleDataEntity entity) {
    return LoginGoogleDataModel(
      email: entity.email,
      googleId: entity.googleId,
      fullName: entity.fullName,
      dateOfBirth: entity.dateOfBirth,
    );
  }

  LoginGoogleDataEntity get entity => LoginGoogleDataEntity(
        email: email,
        googleId: googleId,
        fullName: fullName,
        dateOfBirth: dateOfBirth,
      );
}
