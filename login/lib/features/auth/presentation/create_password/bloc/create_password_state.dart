import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/button_state_model.dart';
import '../../../domain/entity/field_verifiable_model.dart';
import '../../../domain/entity/password_verifiable_model.dart';

part 'create_password_state.freezed.dart';

@freezed
class CreatePasswordState with _$CreatePasswordState {
  const factory CreatePasswordState({
    // PASSWORD SCREEN
    @Default(false) bool reseted,
    @Default(false) bool hasEightCharacters,
    @Default(false) bool hasUppercase,
    @Default(false) bool hasLowercase,
    @Default(false) bool hasDigit,
    @Default(false) bool hasSpecialCharacter,
    required FieldVerifiableModel<String> password,
    required PasswordVerifiableModel verifyPassword,
    required FieldVerifiableModel confirmPassword,
    @Default(ButtonState.inactive) ButtonState nextButton,
  }) = _CreatePassswordState;

  factory CreatePasswordState.defaultState() => CreatePasswordState(
        password: FieldVerifiableModel<String>(
          value: '',
          validationState: ValidationState.unknown,
        ),
        verifyPassword: PasswordVerifiableModel<String>(
          value: '',
          validationState: PasswordValidationState.unknown,
        ),
        confirmPassword: FieldVerifiableModel<String>(
          value: '',
          validationState: ValidationState.unknown,
        ),
        nextButton: ButtonState.inactive,
      );
}
