import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/features/auth/domain/entity/credentials_entity.dart';
import 'package:login/features/auth/domain/repository/auth_repository.dart';

class RequestConfirmationCode extends UseCase<Duration, CredentialEntity> {
  final AuthRepository authRepository;

  RequestConfirmationCode({required this.authRepository});

  @override
  Future<Either<Failure, Duration>> call(CredentialEntity params) async {
    final result = await authRepository.requestCode(params);
    return result.fold(
      (l) => Left(l as Failure),
      (r) => Right(r),
    );
  }
}
