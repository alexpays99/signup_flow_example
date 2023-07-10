part of 'add_full_name_bloc.dart';

@freezed
class AddFullNameEvent with _$AddFullNameEvent {
  // NAME SCREEN
  factory AddFullNameEvent.nameInput({required String nameInputData}) =
      _NameInput;
}
