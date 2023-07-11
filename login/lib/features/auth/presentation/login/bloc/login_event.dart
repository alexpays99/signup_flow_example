part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  //LOGIN SCREEN
  const factory LoginEvent.loginPhoneOrEmailInput({required String inputData}) =
      _LoginPhoneOrEmailInput;
  const factory LoginEvent.loginPasswordInput({required String inputData}) =
      _LoginPasswordInput;
  const factory LoginEvent.loginButtonPressed() = _LoginButtonPressed;
  const factory LoginEvent.loginWithGooglePressed() = _LoginWithGooglePressed;
  const factory LoginEvent.resetLoginScreenState() = _ResetLoginScreenState;
}
