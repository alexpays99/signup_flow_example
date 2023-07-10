import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/core/domain/entity/failure.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure extends Failure with _$AuthFailure {
  const factory AuthFailure.local({required String message}) = _Local;

  const factory AuthFailure.remote({
    required String message,
    int? code,
  }) = _Remote;

  const factory AuthFailure.facebookNoEmail({
    required String message,
  }) = _FacebookNoEmail;
}
