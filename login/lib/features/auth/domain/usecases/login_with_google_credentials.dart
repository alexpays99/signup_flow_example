import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/entity/user.dart';
import 'package:login/features/auth/domain/repository/user_repository.dart';

import '../entity/auth_failure.dart';
import '../repository/auth_repository.dart';

class LoginWithGoogleCredentials {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  LoginWithGoogleCredentials({
    required this.authRepository,
    required this.userRepository,
  });

  Future<Either<Failure, UserEntity>> call() async {
    final loginGoogleData = await authRepository.getAllLoginGoogleData();
    loginGoogleData?.fold(
      (l) => Left(l),
      (r) async {
        final authResult = await authRepository.signInWithGoogleCredentials(r);
        print(authResult);
        authResult.fold(
          (l) => Left(l),
          (r) async {
            final userData = await userRepository.getUser();
            userData.fold(
              (l) => Left(l),
              (r) => Right(r),
            );
          },
        );
      },
    );
    return Left(
        const AuthFailure.local(message: 'Something went wrong') as Failure);
  }
}
