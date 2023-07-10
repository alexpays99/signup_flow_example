enum PasswordValidationState {
  unknown,
  hasEightCharacters,
  hasUppercase,
  hasLowercase,
  hasDigits,
  hasSpecialCharacter,
}

class PasswordVerifiableModel<DataType> {
  DataType value;
  PasswordValidationState validationState;
  String? message;

  PasswordVerifiableModel({
    required this.value,
    required this.validationState,
    this.message,
  });
}
