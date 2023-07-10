import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/features/auth/domain/entity/sign_up_data_entity.dart';
import 'package:login/features/auth/domain/repository/auth_repository.dart';

import '../repository/user_repository.dart';

class SignUp extends UseCase<bool, SignUpDataEntity> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SignUp({
    required this.authRepository,
    required this.userRepository,
  });

  @override
  Future<Either<Failure, bool>> call(SignUpDataEntity params) async {
    final response = await authRepository.signUp(params);
    return response.fold(
      (l) {
        return Left(l as Failure);
      },
      (r) async {
        final userRepoResponse = await userRepository.getUser();
        return userRepoResponse.fold(
          (l) {
            return Left(l as Failure);
          },
          (r) {
            return const Right(true);
          },
        );
      },
    );
  }
}
