import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/auth/domain/entity/credentials_entity.dart';

part 'credential_model.freezed.dart';

part 'credential_model.g.dart';

@freezed
class CredentialsModel with _$CredentialsModel {
  const CredentialsModel._();

  @Assert('email != null ||phoneNumber != null')
  @JsonSerializable(includeIfNull: false)
  const factory CredentialsModel({
    String? email,
    String? phoneNumber,
    required String password,
  }) = _CredentialsModel;

  factory CredentialsModel.fromJson(Map<String, dynamic> json) =>
      _$CredentialsModelFromJson(json);

  factory CredentialsModel.fromEntity(CredentialEntity entity) {
    return CredentialsModel(
        password: entity.password,
        email: entity.email,
        phoneNumber: entity.phoneNumber);
  }

  ///Return email or password json depending on which is present
  Map<String, dynamic> existingIdentifierJson() {
    if (email != null) {
      return {'email': email};
    } else {
      return {'phoneNumber': phoneNumber};
    }
  }

  CredentialEntity get entity => CredentialEntity(
        password: password,
        phoneNumber: phoneNumber,
        email: email,
      );
}
