import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/features/auth/domain/entity/credentials_entity.dart';
import 'package:login/features/auth/domain/repository/auth_repository.dart';

class ResetPassword extends UseCase<bool, CredentialEntity> {
  final AuthRepository authRepository;

  ResetPassword({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(params) async {
    final response = await authRepository.resetPassword(params);
    return response;
  }
}
