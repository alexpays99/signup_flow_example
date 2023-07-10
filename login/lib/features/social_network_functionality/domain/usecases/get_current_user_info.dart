import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/entity/user.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/features/auth/domain/entity/auth_failure.dart';
import 'package:login/features/auth/domain/repository/user_repository.dart';

class GetCurrentUserInfo extends UseCase<UserEntity, NoParams> {
  final UserRepository userRepository;

  GetCurrentUserInfo({
    required this.userRepository,
  });

  @override
  Future<Either<Failure, UserEntity>> call(
    NoParams params,
  ) async {
    try {
      final userRepoResult = await userRepository.getUser();
      return userRepoResult.fold(
        (l) {
          return Left(l);
        },
        (r) async {
          return Right(r);
        },
      );
    } catch (e) {
      print(e);
      return const Left(
        AuthFailure.local(
            message: "Something went wrong while fetching from user repo."),
      );
    }
  }
}
