import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/keys/local_storage_keys.dart';
import 'package:login/features/auth/domain/entity/auth_failure.dart';
import 'package:login/features/auth/domain/entity/user_token.dart';

class UserStorageService {
  final FlutterSecureStorage storage;

  UserStorageService({required this.storage});

  Future<bool> haveTokens() async {
    final isAccessTokenPresent =
        await storage.containsKey(key: LocalStorageKeys.accessTokenKey);
    final isStorageTokenPresent =
        await storage.containsKey(key: LocalStorageKeys.refreshTokenKey);
    return isAccessTokenPresent && isStorageTokenPresent;
  }

  Future<Either<Failure, UserTokens>> getTokens() async {
    try {
      final accessToken =
          await storage.read(key: LocalStorageKeys.accessTokenKey);
      final refreshToken =
          await storage.read(key: LocalStorageKeys.refreshTokenKey);
      if (accessToken != null && refreshToken != null) {
        return Right(
            UserTokens(accessToken: accessToken, refreshToken: refreshToken));
      } else {
        return Left(
            const AuthFailure.local(message: 'Some tokens are missing'));
      }
    } catch (e) {
      return Left(
          const AuthFailure.local(message: 'Failed to read from storage'));
    }
  }

  Future<Either<Failure, bool>> saveTokens(UserTokens tokens) async {
    try {
      // Here should be real access and refresh tokens from alive back.
      await storage.write(
          key: LocalStorageKeys.accessTokenKey, value: 'alsdhfaslkdjfhasdfj');
      await storage.write(
          key: LocalStorageKeys.refreshTokenKey,
          value: 'asdfl;sadhfasdgfkjasdfhasdf');
      return const Right(true);
    } catch (e) {
      return const Left(
          AuthFailure.local(message: 'Exception while writing tokens'));
    }
  }

  Future<Either<Failure, bool>> clearTokens() async {
    try {
      await storage.deleteAll();
      return const Right(true);
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Exception while deleting'));
    }
  }
}
