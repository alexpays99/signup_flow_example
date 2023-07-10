part of 'phone_or_email_cubit.dart';

enum Tabs {
  phone,
  email;

  factory Tabs.fromIndex(int index) {
    switch (index) {
      case 0:
        return phone;
      case 1:
        return email;
      default:
        return phone;
    }
  }
}

@freezed
class PhoneOrEmailState with _$PhoneOrEmailState {
  const factory PhoneOrEmailState({
    // PHONE OR EMAIL SCREEN
    @Default(Tabs.phone) Tabs currentTab,
    @Default(false) bool isValidated,
    required FieldVerifiableModel<String> phone,
    required FieldVerifiableModel<String> email,
    ButtonState? nextPhoneOrEmailButton,
  }) = _PhoneOrEmailState;

  factory PhoneOrEmailState.defaultState() => PhoneOrEmailState(
        phone: FieldVerifiableModel<String>(
          value: '',
          validationState: ValidationState.unknown,
        ),
        email: FieldVerifiableModel<String>(
          value: '',
          validationState: ValidationState.unknown,
        ),
        nextPhoneOrEmailButton: ButtonState.inactive,
      );
}
