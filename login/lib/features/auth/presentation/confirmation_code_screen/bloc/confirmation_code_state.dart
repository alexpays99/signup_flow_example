import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/auth/domain/entity/button_state_model.dart';

part 'confirmation_code_state.freezed.dart';

@freezed
class ConfirmationCodeState with _$ConfirmationCodeState {
  const factory ConfirmationCodeState({
    required String code,
    required Duration timeout,
    @Default(false) bool resendBlocked,
    @Default(ButtonState.inactive) ButtonState buttonState,
    String? codeValidationError,
    String? codeResendTimeout,
    @Default(false) bool validationCompleted,
  }) = _ConfirmationCodeState;
}
