import 'package:freezed_annotation/freezed_annotation.dart';

part 'credentials_entity.freezed.dart';

@freezed
class CredentialEntity with _$CredentialEntity {
  @Assert('email != null ||phoneNumber != null')
  const factory CredentialEntity({
    String? email,
    String? phoneNumber,
    required String password,
  }) = _CredentialEntity;
}
