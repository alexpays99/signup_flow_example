import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/auth/domain/entity/form_validation_model.dart';
import 'package:login/translations/locale_keys.g.dart';

import '../../../../../core/injection_container.dart';
import '../../../domain/entity/button_state_model.dart';
import '../../../domain/entity/credentials_entity.dart';
import '../../../domain/entity/field_verifiable_model.dart';
import '../../../domain/usecases/login_with_credentials.dart';
import '../../../domain/usecases/login_with_google_credentials.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginWithCredentials loginWithCredentials;

  LoginBloc({
    required this.loginWithCredentials,
  }) : super(
          LoginState(
            dialogueError: null,
            loginPhoneOrEmail: FieldVerifiableModel(
              value: '',
              validationState: ValidationState.unknown,
            ),
            loginPassword: FieldVerifiableModel(
              value: '',
              validationState: ValidationState.unknown,
            ),
            loginButton: ButtonState.active,
          ),
        ) {
    on<LoginEvent>(_onUserEvent);
  }

  final signInWithGoogle = getIt.get<LoginWithGoogleCredentials>();

  String? phoneNumber(String? phone) {
    if (phone == null) {
      return null;
    } else {
      final formattedPhone = phone.substring(phone.length - 9);
      return '+380$formattedPhone';
    }
  }

  void _onUserEvent(LoginEvent event, Emitter<LoginState> emit) async {
    await event.when(
      loginPhoneOrEmailInput: (String inputData) {
        emit(
          state.copyWith(
            loginPhoneOrEmail: FieldVerifiableModel(
              value: inputData,
              validationState: ValidationState.valid,
            ),
            dialogueError: null,
          ),
        );
        print(state.loginPhoneOrEmail.value);
      },
      loginPasswordInput: (String inputData) {
        emit(
          state.copyWith(
            loginPassword: FieldVerifiableModel(
              value: inputData,
              validationState: ValidationState.unknown,
            ),
            dialogueError: null,
          ),
        );
      },
      loginButtonPressed: () async {
        final String? email;
        final String? phone;
        emit(
          state.copyWith(
            loginButton: ButtonState.loading,
          ),
        );
        if (!(state.loginPhoneOrEmail.value.isEmpty &&
            state.loginPassword.value.isEmpty)) {
          if (state.loginPhoneOrEmail.value.contains('@')) {
            email = state.loginPhoneOrEmail.value;
            phone = null;
          } else {
            phone = state.loginPhoneOrEmail.value;
            email = null;
          }

          final credentials = CredentialEntity(
            password: state.loginPassword.value,
            email: email,
            phoneNumber: phoneNumber(phone),
          );
          print(credentials.toString());
          final loginResult = await loginWithCredentials(credentials);

          print(loginResult);
          loginResult.fold(
            (l) {
              emit(
                state.copyWith(
                  loginPhoneOrEmail: FieldVerifiableModel(
                    value: state.loginPhoneOrEmail.value,
                    validationState: ValidationState.invalid,
                  ),
                  dialogueError: DialogueErrorEntity(
                    title: LocaleKeys.loginAlertTitle.tr(),
                    message: LocaleKeys.loginAlertContent.tr(),
                  ),
                  loginPassword: FieldVerifiableModel(
                    value: state.loginPassword.value,
                    validationState: ValidationState.invalid,
                  ),
                  loginButton: ButtonState.active,
                ),
              );
            },
            (r) {},
          );
        } else {
          emit(
            state.copyWith(
              dialogueError: DialogueErrorEntity(
                title: LocaleKeys.loginAlertTitle.tr(),
                message: LocaleKeys.loginAlertContent.tr(),
              ),
              loginButton: ButtonState.active,
            ),
          );
        }
        emit(
          state.copyWith(
            dialogueError: null,
          ),
        );
      },
      loginWithGooglePressed: () async {
        await signInWithGoogle.call();
      },
      resetLoginScreenState: () {
        emit(
          LoginState(
            dialogueError: null,
            loginPhoneOrEmail: FieldVerifiableModel(
              value: '',
              validationState: ValidationState.unknown,
            ),
            loginPassword: FieldVerifiableModel(
              value: '',
              validationState: ValidationState.unknown,
            ),
            loginButton: ButtonState.active,
          ),
        );
      },
    );
  }
}
