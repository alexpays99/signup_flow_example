part of 'add_bio_cubit.dart';

@freezed
class AddBioState with _$AddBioState {
  const factory AddBioState({
    @Default(false) bool isValidated,
    FieldVerifiableModel? bio,
    ButtonState? nextButton,
  }) = _AddBioState;
}
