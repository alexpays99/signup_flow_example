import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/auth/domain/entity/sign_up_data_entity.dart';

part 'sign_up_data_model.freezed.dart';

part 'sign_up_data_model.g.dart';

@freezed
class SignUpDataModel with _$SignUpDataModel {
  const SignUpDataModel._();

  @Assert('email != null ||phoneNumber != null')
  @JsonSerializable(includeIfNull: false)
  const factory SignUpDataModel({
    String? email,
    String? phoneNumber,
    required String password,
    required String nickname,
    required String fullName,
    required String dateOfBirth,
  }) = _SignUpDataModel;

  factory SignUpDataModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpDataModelFromJson(json);

  factory SignUpDataModel.fromEntity(SignUpDataEntity entity) {
    if (entity.isValid()) {
      return SignUpDataModel(
        password: entity.password!,
        email: entity.email,
        phoneNumber: entity.phoneNumber,
        nickname: entity.nickname!,
        fullName: entity.fullName!,
        dateOfBirth: entity.dateOfBirth!,
      );
    } else {
      throw Exception('Incorrect model');
    }
  }

  SignUpDataEntity get entity => SignUpDataEntity(
        password: password,
        phoneNumber: phoneNumber,
        email: email,
        nickname: nickname,
        fullName: fullName,
        dateOfBirth: dateOfBirth,
      );
}
