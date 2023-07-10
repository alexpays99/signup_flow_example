part of 'edit_profile_cubit.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    String? photo,
    FieldVerifiableModel? fullName,
    FieldVerifiableModel? nickname,
    @Default(false) bool isUSerUpdated,
    FieldVerifiableModel? city,
    FieldVerifiableModel? bio,
    ButtonState? saveChangesButton,
  }) = _EditProfileState;
}
