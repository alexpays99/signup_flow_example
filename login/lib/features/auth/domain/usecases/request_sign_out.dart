import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/features/auth/domain/repository/auth_repository.dart';

class RequestSignOut extends UseCase<bool, NoParams> {
  AuthRepository authRepository;

  RequestSignOut({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final result = await authRepository.requestSignOut();
    return result.fold(
      (l) => Left(l as Failure),
      (r) => Right(r),
    );
  }
}
