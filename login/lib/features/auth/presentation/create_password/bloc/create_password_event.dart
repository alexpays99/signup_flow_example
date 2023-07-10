import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/credentials_entity.dart';

part 'create_password_event.freezed.dart';

@freezed
class CreatePasswordEvent with _$CreatePasswordEvent {
  const factory CreatePasswordEvent.resetState() = _ResetState;

  const factory CreatePasswordEvent.passwordInput(
      {required String passwordInputData}) = _PasswordInput;

  const factory CreatePasswordEvent.confirmPasswordInput(
      {required String inputData}) = _ConfirmPasswordInput;

  const factory CreatePasswordEvent.resetPassword(
      CredentialEntity credentialEntity) = _ResetPassword;
}
