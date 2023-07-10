part of 'create_nickname_cubit.dart';

@freezed
class CreateNicknameState with _$CreateNicknameState {
  factory CreateNicknameState({
    // NICKNAME SCREEN
    FieldVerifiableModel? nickname,
    ButtonState? nextNicknameButton,
  }) = _CreateNicknameState;
}
