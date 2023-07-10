import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/core/domain/entity/user.dart';

part 'auth_state.freezed.dart';

///TODO add implementation
@freezed
class AuthState with _$AuthState {
  const factory AuthState.unidentified() = _Unidentified;
  const factory AuthState.loggedIn(UserEntity userEntity) = _LoggedIn;
  const factory AuthState.loggedOut() = _LoggedOut;
}
