part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
// LOGIN SCREEN
    DialogueErrorEntity? dialogueError,
    required FieldVerifiableModel<String> loginPhoneOrEmail,
    required FieldVerifiableModel<String> loginPassword,
    required ButtonState? loginButton,
  }) = _LoginState;
}
