import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_data_entity.freezed.dart';

@freezed
class SignUpDataEntity with _$SignUpDataEntity {
  const SignUpDataEntity._();

  const factory SignUpDataEntity({
    String? email,
    String? phoneNumber,
    String? password,
    String? nickname,
    String? fullName,
    String? dateOfBirth,
  }) = _SignUpDataEntity;

  bool isValid() {
    if (email != null || phoneNumber != null) {
      return password != null &&
          nickname != null &&
          fullName != null &&
          dateOfBirth != null;
    } else {
      return false;
    }
  }
}
