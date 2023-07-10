import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/features/auth/domain/entity/credentials_entity.dart';
import 'package:login/features/auth/domain/repository/auth_repository.dart';

class SendConfirmationCode extends UseCase<bool, Params> {
  final AuthRepository authRepository;

  SendConfirmationCode({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    final result = await authRepository.validateCode(
        credentials: params.credentials, code: params.code);
    return result.fold(
      (l) => Left(l as Failure),
      (r) => Right(r),
    );
  }
}

class Params {
  final CredentialEntity credentials;
  final String code;

  Params({
    required this.credentials,
    required this.code,
  });
}
