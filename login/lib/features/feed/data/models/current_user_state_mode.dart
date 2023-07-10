import 'package:login/core/domain/entity/user.dart';

enum CurrentUserState {
  initial,
  loading,
  loaded,
  error,
}

class CurrentUserStateModel {
  UserEntity? value;
  CurrentUserState? currentUserState;
  String? message;

  CurrentUserStateModel({
    required this.value,
    required this.currentUserState,
    this.message,
  });
}
