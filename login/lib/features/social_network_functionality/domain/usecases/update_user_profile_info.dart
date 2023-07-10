import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/entity/user.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/features/auth/domain/repository/user_repository.dart';

import '../../../auth/domain/entity/setup_profile_data_entity.dart';

class UpdateUserProfileInfo
    extends UseCase<UserEntity, SetupProfileDataEntity> {
  final UserRepository userRepository;

  UpdateUserProfileInfo({
    required this.userRepository,
  });

  @override
  Future<Either<Failure, UserEntity>> call(
    SetupProfileDataEntity? params,
  ) async {
    final userRepoResult = await userRepository.updateUser(params);
    return userRepoResult.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        return Right(r);
      },
    );
  }
}
