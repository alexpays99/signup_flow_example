import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/features/auth/domain/repository/user_repository.dart';

import '../entity/auth_failure.dart';
import '../repository/auth_repository.dart';

class SignOut {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SignOut({
    required this.authRepository,
    required this.userRepository,
  });

  Future<Either<Failure, bool>> call() async {
    //Clear tokens
    final signout = await authRepository.requestSignOut();
    return signout.fold(
      (l) => Left(l as Failure),
      (r) async {
        if (r == true) {
          //Clear User
          final userData = await userRepository.clearUser();
          return userData.fold(
            (l) => Left(l as Failure),
            (r) => Right(r),
          );
        } else {
          return Left(const AuthFailure.local(message: 'Failed to sign out')
              as Failure);
        }
      },
    );
  }
}
