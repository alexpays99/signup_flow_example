import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/auth/domain/entity/sign_up_data_entity.dart';

part 'confirmation_code_event.freezed.dart';

@freezed
class ConfirmationCodeEvent with _$ConfirmationCodeEvent {
  const factory ConfirmationCodeEvent.requestCode(
    SignUpDataEntity signUpDataEntity,
  ) = _RequestCode;

  const factory ConfirmationCodeEvent.sendCode(
    SignUpDataEntity signUpDataEntity,
  ) = _SendCode;

  const factory ConfirmationCodeEvent.sendCodeAnSignUp(
    SignUpDataEntity signUpDataEntity,
  ) = _SendCodeAnSignUp;
  const factory ConfirmationCodeEvent.clearState() = _ClearState;

  const factory ConfirmationCodeEvent.timerTicked() = _TimerTicked;

  const factory ConfirmationCodeEvent.codeChanged(String code) = _CodeChanged;
}
