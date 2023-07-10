import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/core/domain/entity/user.dart';

part 'auth_event.freezed.dart';

///TODO add implementation
@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signIn(UserEntity userEntity) = _SignedIn;
  const factory AuthEvent.signOut() = _SignedOut;
}
