import 'package:dartz/dartz.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/features/auth/domain/entity/auth_failure.dart';
import 'package:login/features/auth/domain/repository/auth_repository.dart';

class LoginWithFacebook extends UseCase<bool, NoParams> {
  AuthRepository authRepository;

  LoginWithFacebook({required this.authRepository});

  @override
  Future<Either<AuthFailure, bool>> call(NoParams params) async {
    final response = await authRepository.loginWIthFacebook();
    return response.fold(
      (l) => Left(l),
      (r) {
        return const Right(true);
      },
    );
  }
}
