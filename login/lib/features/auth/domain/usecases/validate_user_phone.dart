import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class ValidateUserPhone extends UseCase<bool, String> {
  final AuthRepository authRepository;

  ValidateUserPhone({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, bool>> call(String params) async {
    final authResult = await authRepository.checkUserPhoneValid(params);
    return authResult.fold(
      (l) {
        return Left(l as Failure);
      },
      (r) => Right(r),
    );
  }
}
