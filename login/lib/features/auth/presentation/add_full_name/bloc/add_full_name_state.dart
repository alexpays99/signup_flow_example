part of 'add_full_name_bloc.dart';

@freezed
class AddFullNameState with _$AddFullNameState {
  const factory AddFullNameState({
    // NAME SCREEN
    FieldVerifiableModel? name,
    ButtonState? nextNameButton,
  }) = _AddFullNameState;
}
