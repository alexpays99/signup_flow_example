import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/user.dart';
import 'package:login/features/auth/domain/entity/auth_failure.dart';
import 'package:login/features/auth/sevices/user_storage_service.dart';
import '../../../../core/servises/main_service.dart';
import '../../domain/entity/setup_profile_data_entity.dart';
import '../../domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserStorageService userStorage;
  final MainService mainService;
  final StreamController<UserEntity?> _userUpdateController =
      StreamController();
  UserEntity? _currentUser;

  UserRepositoryImpl({
    required this.userStorage,
    required this.mainService,
  });

  @override
  Future<Either<AuthFailure, bool>> clearUser() async {
    try {
      _currentUser = null;
      _userUpdateController.add(null);
      return right(true);
    } catch (e) {
      return left(
          const AuthFailure.local(message: 'Failed to delete user date'));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> getUser() async {
    if (_currentUser != null) {
      return Right(_currentUser!);
    } else {
      final tokens = await userStorage.getTokens();
      return tokens.fold(
        (l) {
          return Left(AuthFailure.local(message: l.message));
        },
        (r) async {
          final user = await mainService.currentUser(r.accessToken);

          return user.fold(
            (l) => Left(
              AuthFailure.local(message: l.message),
            ),
            (r) {
              _currentUser = r;
              _userUpdateController.add(_currentUser);
              return Right(r);
            },
          );
        },
      );
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> updateUser(
    SetupProfileDataEntity? profileDataEntity,
  ) async {
    try {
      final setupProfileDataEntity = await mainService.updateUser(
        profileDataEntity?.photo,
        profileDataEntity?.fullName,
        profileDataEntity?.nickname,
        profileDataEntity?.city,
        profileDataEntity?.bio,
      );
      return setupProfileDataEntity.fold(
        (l) => Left(AuthFailure.local(message: l.message)),
        (r) async {
          _currentUser = r.entity;
          _userUpdateController.add(_currentUser);
          return Right(r.entity);
        },
      );
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something went wrong'));
    }
  }

  @override
  Stream<UserEntity?> get userUpdateStream => _userUpdateController.stream;
}
