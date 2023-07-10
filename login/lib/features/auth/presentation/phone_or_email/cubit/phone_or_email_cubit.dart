import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../translations/locale_keys.g.dart';
import '../../../domain/entity/button_state_model.dart';
import '../../../domain/entity/field_verifiable_model.dart';
import '../../../domain/usecases/validate_user_email.dart';
import '../../../domain/usecases/validate_user_phone.dart';

part 'phone_or_email_state.dart';

part 'phone_or_email_cubit.freezed.dart';

class PhoneOrEmailCubit extends Cubit<PhoneOrEmailState> {
  PhoneOrEmailCubit({
    required this.validateUserPhone,
    required this.validateUserEmail,
  }) : super(
          PhoneOrEmailState.defaultState(),
        );

  final ValidateUserEmail validateUserEmail;
  final ValidateUserPhone validateUserPhone;

  void toDefaultState() {
    emit(PhoneOrEmailState.defaultState());
  }

  void phoneInput(String phoneInputData) {
    final prefixedPhoneNumber = '+380$phoneInputData';
    if (phoneInputData.isEmpty) {
      _emitState(
        phoneData: FieldVerifiableModel(
          value: prefixedPhoneNumber,
          validationState: ValidationState.unknown,
        ),
      );
      _emitButtonState(buttonState: ButtonState.inactive);
    } else {
      if (phoneInputData.length == 9) {
        _emitState(
          phoneData: FieldVerifiableModel(
            value: prefixedPhoneNumber,
            validationState: ValidationState.valid,
          ),
        );
        _emitButtonState(buttonState: ButtonState.active);
      } else {
        _emitState(
          phoneData: FieldVerifiableModel(
            value: prefixedPhoneNumber,
            validationState: ValidationState.invalid,
            message: LocaleKeys.phoneValidaitonError.tr(),
          ),
        );
        _emitButtonState(buttonState: ButtonState.inactive);
      }
    }
  }

  void emailInput(String input) {
    if (EmailValidator.validate(input)) {
      _emitState(
        emailData: FieldVerifiableModel(
          value: input,
          validationState: ValidationState.valid,
        ),
      );
      _emitButtonState(buttonState: ButtonState.active);
    } else {
      _emitState(
        emailData: FieldVerifiableModel(
          value: input,
          validationState: ValidationState.invalid,
        ),
      );
      _emitButtonState(buttonState: ButtonState.inactive);
    }
  }

  Future _validatePhone([bool reversal = true]) async {
    _emitButtonState(buttonState: ButtonState.loading);

    final phoneExist = await validateUserPhone(state.phone.value);

    phoneExist.fold(
      (l) {
        _emitState(
          phoneData: FieldVerifiableModel(
            value: state.phone.value,
            validationState: ValidationState.unknown,
            message: LocaleKeys.unexpectedError.tr(),
          ),
        );
        _emitButtonState(buttonState: ButtonState.inactive);
      },
      (r) {
        if (r != reversal) {
          _emitState(
            phoneData: FieldVerifiableModel(
              value: state.phone.value,
              validationState: ValidationState.valid,
            ),
          );
          _emitButtonState(buttonState: ButtonState.active);
          emit(
            state.copyWith(
              isValidated: true,
            ),
          );
        } else {
          _emitState(
            phoneData: FieldVerifiableModel(
              value: state.phone.value,
              validationState: ValidationState.invalid,
              message: reversal
                  ? LocaleKeys.phoneAlreadyUsed.tr()
                  : LocaleKeys.passwordRecoveryAccountNotFound.tr(),
            ),
          );
          _emitButtonState(buttonState: ButtonState.inactive);
        }
      },
    );
  }

  Future _validateEmail([bool reversal = true]) async {
    _emitButtonState(buttonState: ButtonState.loading);

    final emailExist = await validateUserEmail(state.email.value);

    emailExist.fold(
      (l) {
        _emitState(
          emailData: FieldVerifiableModel(
            value: state.email.value,
            validationState: ValidationState.unknown,
            message: LocaleKeys.unexpectedError.tr(),
          ),
        );
        _emitButtonState(buttonState: ButtonState.inactive);
      },
      (r) {
        if (r != reversal) {
          _emitState(
            emailData: FieldVerifiableModel(
              value: state.email.value,
              validationState: ValidationState.valid,
            ),
          );
          _emitButtonState(buttonState: ButtonState.active);
          emit(
            state.copyWith(
              isValidated: true,
            ),
          );
        } else {
          _emitState(
            emailData: FieldVerifiableModel(
              value: state.email.value,
              validationState: ValidationState.invalid,
              message: reversal
                  ? LocaleKeys.emailAlreadyUsed.tr()
                  : LocaleKeys.passwordRecoveryAccountNotFound.tr(),
            ),
          );
          _emitButtonState(buttonState: ButtonState.inactive);
        }
      },
    );
  }

  void _emitState({
    FieldVerifiableModel<String>? phoneData,
    FieldVerifiableModel<String>? emailData,
  }) {
    emit(
      state.copyWith(
        phone: phoneData ??
            FieldVerifiableModel<String>(
              value: '',
              validationState: ValidationState.unknown,
            ),
        email: emailData ??
            FieldVerifiableModel<String>(
              value: '',
              validationState: ValidationState.unknown,
            ),
      ),
    );
  }

  void tabChanged(int tabIndex) {
    emit(
      state.copyWith(
        currentTab: Tabs.fromIndex(tabIndex),
      ),
    );
  }

  void nextButtonPressed() async {
    switch (state.currentTab) {
      case Tabs.phone:
        await _validatePhone();
        break;
      case Tabs.email:
        await _validateEmail();
        break;
    }
    emit(
      state.copyWith(
        isValidated: false,
      ),
    );
  }

  void recoveryNextButtonPressed() async {
    switch (state.currentTab) {
      case Tabs.phone:
        await _validatePhone(false);
        break;
      case Tabs.email:
        await _validateEmail(false);
        break;
    }
    emit(
      state.copyWith(
        isValidated: false,
      ),
    );
  }

  void _emitButtonState({required ButtonState buttonState}) {
    emit(
      state.copyWith(nextPhoneOrEmailButton: buttonState),
    );
  }
}
