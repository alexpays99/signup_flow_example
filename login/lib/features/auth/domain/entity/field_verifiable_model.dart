enum ValidationState {
  valid,
  invalid,
  unknown,
}

class FieldVerifiableModel<DataType> {
  DataType value;
  ValidationState validationState;
  String? message;

  FieldVerifiableModel({
    required this.value,
    required this.validationState,
    this.message,
  });
}
