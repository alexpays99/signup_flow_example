import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/core/config/regexp_rules.dart';
import 'package:login/features/auth/domain/entity/button_state_model.dart';
import 'package:login/features/auth/domain/entity/credentials_entity.dart';
import 'package:login/features/auth/domain/entity/sign_up_data_entity.dart';
import 'package:login/features/auth/presentation/confirmation_code_screen/bloc/confirmation_code_event.dart';
import 'package:login/features/auth/presentation/confirmation_code_screen/bloc/confirmation_code_state.dart';
import 'package:login/translations/locale_keys.g.dart';

import '../../../domain/usecases/request_confirmation_code.dart';
import '../../../domain/usecases/send_confirmation_code.dart';
import '../../../domain/usecases/sign_up.dart';
import '../../../sevices/timeout_service/timeout_service_keys.dart';

class ConfirmationCodeBloc
    extends Bloc<ConfirmationCodeEvent, ConfirmationCodeState> {
  final RequestConfirmationCode requestConfirmationCode;
  final SendConfirmationCode sendConfirmationCode;
  final SignUp signUp;
  Timer? timer;

  ConfirmationCodeBloc(
    this.requestConfirmationCode,
    this.sendConfirmationCode,
    this.signUp,
  ) : super(
          const ConfirmationCodeState(
            code: '',
            timeout: Duration.zero,
          ),
        ) {
    on<ConfirmationCodeEvent>(
      (event, emit) async {
        await event.map(
          requestCode: (requestCode) async {
            emit(state.copyWith(resendBlocked: true));

            final response = await requestConfirmationCode(
              CredentialEntity(
                ///Password don't really needed here
                password: requestCode.signUpDataEntity.password ?? '',
                email: requestCode.signUpDataEntity.email,
                phoneNumber: requestCode.signUpDataEntity.phoneNumber,
              ),
            );
            response.fold(
              (l) {
                emit(state.copyWith(resendBlocked: false));
              },
              (r) {
                emit(
                  state.copyWith(
                    timeout: r,
                    codeResendTimeout: r >
                            const Duration(
                                seconds: TimeoutSettings.normalTimeout)
                        ? LocaleKeys.confirmationCodeRequestLimitExceeded.tr()
                        : null,
                  ),
                );
                _startTimer();
              },
            );
          },
          sendCode: (sendCode) async {
            ///checking that all crucial values are not null

            emit(
              state.copyWith(
                buttonState: ButtonState.loading,
              ),
            );
            final response = await sendConfirmationCode(
              Params(
                credentials: CredentialEntity(
                  email: sendCode.signUpDataEntity.email,
                  phoneNumber: sendCode.signUpDataEntity.phoneNumber,
                  password: sendCode.signUpDataEntity.password ?? '',
                ),
                code: state.code,
              ),
            );
            await response.fold(
              (l) {
                emit(
                  state.copyWith(
                    codeValidationError:
                        LocaleKeys.confirmationCodeInvalidCode.tr(),
                    buttonState: ButtonState.inactive,
                  ),
                );
              },
              (r) async {
                if (r) {
                  emit(
                    state.copyWith(
                      validationCompleted: true,
                    ),
                  );
                } else {
                  emit(
                    state.copyWith(
                      codeValidationError:
                          LocaleKeys.confirmationCodeInvalidCode.tr(),
                    ),
                  );
                }
              },
            );
            emit(
              state.copyWith(
                validationCompleted: false,
              ),
            );
          },
          clearState: (clearState) {
            emit(
              state.copyWith(
                code: '',
                buttonState: ButtonState.inactive,
                codeValidationError: null,
                validationCompleted: false,
              ),
            );
          },
          codeChanged: (codeChanged) {
            emit(
              state.copyWith(
                codeValidationError: null,
                code: codeChanged.code,
                buttonState: _validateCode(codeChanged.code)
                    ? ButtonState.active
                    : ButtonState.inactive,
              ),
            );
          },
          timerTicked: (timerTicked) {
            emit(
              state.copyWith(
                timeout: state.timeout - const Duration(seconds: 1),
              ),
            );
            if (state.timeout <= Duration.zero) {
              timer?.cancel();
              emit(
                state.copyWith(
                  resendBlocked: false,
                  codeResendTimeout: null,
                ),
              );
            }
          },
          sendCodeAnSignUp: (value) async {
            ///checking that all crucial values are not null
            if (value.signUpDataEntity.isValid()) {
              emit(state.copyWith(
                buttonState: ButtonState.loading,
              ));
              final response = await sendConfirmationCode(
                Params(
                  credentials: CredentialEntity(
                    email: value.signUpDataEntity.email,
                    phoneNumber: value.signUpDataEntity.phoneNumber,
                    password: value.signUpDataEntity.password!,
                  ),
                  code: state.code,
                ),
              );
              await response.fold(
                (l) {
                  emit(
                    state.copyWith(
                      codeValidationError:
                          LocaleKeys.confirmationCodeInvalidCode.tr(),
                      buttonState: ButtonState.inactive,
                    ),
                  );
                },
                (r) async {
                  if (r) {
                    await _signUp(value.signUpDataEntity, emit);
                    emit(
                      state.copyWith(
                        validationCompleted: true,
                      ),
                    );
                  } else {
                    emit(
                      state.copyWith(
                        codeValidationError:
                            LocaleKeys.confirmationCodeInvalidCode.tr(),
                      ),
                    );
                  }
                },
              );
            }
          },
        );
      },
    );
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        add(const ConfirmationCodeEvent.timerTicked());
      },
    );
  }

  bool _validateCode(String code) {
    return RegexpRules.confirmationCodeValidator.hasMatch(code);
  }

  Future<void> _signUp(SignUpDataEntity signUpDataEntity, Emitter emit) async {
    final signUpResult = await signUp(signUpDataEntity);
    await signUpResult.fold(
      (l) async {
        emit(
          state.copyWith(
            buttonState: ButtonState.active,
            codeValidationError:
                LocaleKeys.confirmationCodeUnsuccessfulSignUp.tr(),
          ),
        );
      },
      (r) async {},
    );
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
