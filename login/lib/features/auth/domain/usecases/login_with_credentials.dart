import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/entity/user.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/features/auth/domain/entity/credentials_entity.dart';
import 'package:login/features/auth/domain/repository/user_repository.dart';

import '../repository/auth_repository.dart';

class LoginWithCredentials extends UseCase<UserEntity, CredentialEntity> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  LoginWithCredentials({
    required this.authRepository,
    required this.userRepository,
  });

  @override
  Future<Either<Failure, UserEntity>> call(CredentialEntity params) async {
    final authResult = await authRepository.loginWithCredentials(params);
    return authResult.fold(
      (l) {
        return Left(l as Failure);
      },
      (r) async {
        final userData = await userRepository.getUser();
        return userData.fold(
          (l) => Left(l as Failure),
          (r) => Right(r),
        );
      },
    );
  }
}
