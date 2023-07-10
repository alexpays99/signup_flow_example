import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/regexp_rules.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../domain/entity/button_state_model.dart';
import '../../../domain/entity/field_verifiable_model.dart';
import '../../../domain/entity/password_verifiable_model.dart';
import '../../../domain/usecases/reset_password.dart';
import 'create_password_event.dart';
import 'create_password_state.dart';

class CreatePasswordBloc
    extends Bloc<CreatePasswordEvent, CreatePasswordState> {
  final ResetPassword resetPassword;

  CreatePasswordBloc({
    required this.resetPassword,
  }) : super(
          CreatePasswordState.defaultState(),
        ) {
    on<CreatePasswordEvent>((event, emit) async {
      await _onUserEvent(event, emit);
    });
  }

  String? _confirmPassword;

  Future _onUserEvent(
      CreatePasswordEvent event, Emitter<CreatePasswordState> emit) async {
    await event.map(
      passwordInput: (passwordInput) {
        _onPasswordInput(passwordInput.passwordInputData, emit);
      },
      confirmPasswordInput: (confirmPasswordInput) {
        _onConfirmPasswordInput(confirmPasswordInput.inputData, emit);
      },
      resetPassword: (resetPasswordEvent) async {
        emit(
          state.copyWith(
            nextButton: ButtonState.loading,
          ),
        );
        final result = await resetPassword(resetPasswordEvent.credentialEntity);
        result.fold(
          (l) {
            emit(
              state.copyWith(
                nextButton: ButtonState.inactive,
              ),
            );
          },
          (r) {
            emit(
              state.copyWith(
                nextButton: ButtonState.inactive,
                reseted: r,
              ),
            );
          },
        );
      },
      resetState: (resetState) {
        emit(
          CreatePasswordState.defaultState(),
        );
      },
    );
  }

  void _onPasswordInput(String input, Emitter<CreatePasswordState> emit) {
    final passwordValidationResult = _validatePassword(input);
    final passwordVerifiableModel = PasswordVerifiableModel<String>(
      value: input,
      validationState: _mapPasswordValidationState(),
    );
    final confirmPasswordValidationState =
        state.confirmPassword.value == input &&
                passwordValidationResult == ValidationState.valid
            ? ValidationState.valid
            : ValidationState.invalid;
    final message = state.confirmPassword.value == input
        ? ''
        : LocaleKeys.errorConfirmPasswordText.tr();

    emit(
      state.copyWith(
        password: FieldVerifiableModel(
          value: input,
          validationState: passwordValidationResult,
        ),
        verifyPassword: passwordVerifiableModel,
        confirmPassword: FieldVerifiableModel(
          value: _confirmPassword,
          validationState: confirmPasswordValidationState,
          message: message,
        ),
        nextButton: confirmPasswordValidationState == ValidationState.valid
            ? ButtonState.active
            : ButtonState.inactive,
      ),
    );
  }

  ValidationState _validatePassword(String password) {
    emit(
      state.copyWith(
        hasEightCharacters: RegexpRules.hasEightCharacters.hasMatch(password),
        hasUppercase: RegexpRules.hasUppercase.hasMatch(password),
        hasLowercase: RegexpRules.hasLowercase.hasMatch(password),
        hasDigit: RegexpRules.hasDigit.hasMatch(password),
        hasSpecialCharacter: RegexpRules.hasSpecialCharacter.hasMatch(password),
      ),
    );

    if (password.isEmpty ||
        !(state.hasEightCharacters &&
            state.hasUppercase &&
            state.hasLowercase &&
            state.hasDigit &&
            state.hasSpecialCharacter)) {
      return ValidationState.invalid;
    } else {
      return ValidationState.valid;
    }
  }

  PasswordValidationState _mapPasswordValidationState() {
    if (state.hasEightCharacters) {
      return PasswordValidationState.hasEightCharacters;
    } else if (state.hasUppercase) {
      return PasswordValidationState.hasUppercase;
    } else if (state.hasLowercase) {
      return PasswordValidationState.hasLowercase;
    } else if (state.hasDigit) {
      return PasswordValidationState.hasDigits;
    } else if (state.hasSpecialCharacter) {
      return PasswordValidationState.hasSpecialCharacter;
    } else {
      return PasswordValidationState.unknown;
    }
  }

  void _onConfirmPasswordInput(
      String inputData, Emitter<CreatePasswordState> emit) {
    _confirmPassword = inputData;
    final passwordValidationState = state.password.validationState;
    final confirmPasswordValidationState = inputData == state.password.value &&
            passwordValidationState == ValidationState.valid
        ? ValidationState.valid
        : ValidationState.invalid;
    final message = inputData == state.password.value
        ? ''
        : LocaleKeys.errorConfirmPasswordText.tr();

    emit(
      state.copyWith(
        confirmPassword: FieldVerifiableModel(
          value: inputData,
          validationState: confirmPasswordValidationState,
          message: message,
        ),
        nextButton: confirmPasswordValidationState == ValidationState.valid
            ? ButtonState.active
            : ButtonState.inactive,
      ),
    );
  }
}
