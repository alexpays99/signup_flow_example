import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/user.dart';
import 'package:login/features/auth/domain/entity/auth_failure.dart';

import '../entity/setup_profile_data_entity.dart';

abstract class UserRepository {
  Stream<UserEntity?> get userUpdateStream;

  Future<Either<AuthFailure, UserEntity>> getUser();

  Future<Either<AuthFailure, UserEntity>> updateUser(
    SetupProfileDataEntity? profileDataEntity,
  );

  Future<Either<AuthFailure, bool>> clearUser();
}
