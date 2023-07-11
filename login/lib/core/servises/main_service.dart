import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:login/core/domain/entity/user.dart';
import 'package:login/core/servises/main_service_data.dart';
import 'package:login/features/auth/data/models/user.dart';
import 'package:login/features/auth/domain/entity/auth_failure.dart';
import 'package:login/features/social_network_functionality/data/models/post_creation_model.dart';
import 'package:login/features/social_network_functionality/data/models/post_model.dart';
import 'package:login/features/social_network_functionality/domain/entities/general_error.dart';
import '../../features/auth/domain/entity/setup_profile_data_entity.dart';
import '../../features/auth/domain/entity/user_token.dart';
import '../../features/auth/sevices/user_storage_service.dart';
import '../domain/entity/failure.dart';
import '../injection_container.dart';

class MainService {
  final MainServiceData data;
  final Dio dio;

  MainService({
    required this.data,
    required this.dio,
  });

  Future<Either<Failure, UserEntity>> currentUser(String accessToken) async {
    try {
      Logger().d(accessToken);
      if (accessToken == 'alsdhfaslkdjfhasdfj') {
        return const Right(
          UserEntity(
            id: '1',
            email: 'diablo@gmail.com',
            phoneNumber: '+380932319900',
            fullName: 'Diablo Taylor',
            nickname: 'diablo',
            dateOfBirth: '1982-02-08',
            photo: '',
            city: 'Kyiv',
            bio: 'something',
            createdAt: '',
          ),
        );
      }
    } catch (e) {
      print(e);
      return Left(AuthFailure.remote(message: e.toString()));
    }
    return const Left(
      AuthFailure.remote(
          message:
              "Something went wrong while making request for getting current "
              "user info"),
    );
  }

  Future<Either<Failure, UserModel>> updateUser(
    String? path,
    String? fullName,
    String? nickname,
    String? city,
    String? bio,
  ) async {
    if (path != null && path != '' && !path.startsWith('http')) {
      try {
        final file = File(path);
        final base64String = base64Encode(await file.readAsBytes());
        final formData = {
          "photo": base64String,
          "fullName": fullName,
          "nickname": nickname,
          "city": city,
          "bio": bio,
        };

        final userTokens = await getIt.get<UserStorageService>().getTokens();
        var tokens = userTokens.fold(
          (l) => l.message,
          (r) => r,
        );

        if (tokens is UserTokens) {
          final response = await dio.patch(
            data.updateUser,
            data: formData,
            options: Options(
              headers: {
                "Authorization": "Bearer ${tokens.accessToken}",
              },
            ),
          );
          print(response.data);
          if (response.statusCode == 401 || response.statusCode == 500) {
            return Left(AuthFailure.remote(message: response.toString()));
          }
          return Right(
            UserModel.fromJson(response.data),
          );
        }
      } catch (e) {
        print(e);
        return Left(AuthFailure.remote(message: e.toString()));
      }
    }
    return const Left(AuthFailure.remote(message: 'Error'));
  }

  Future<Either<Failure, List<PostModel>>?> getAllUserPosts(
      String userId, String? page) async {
    try {
      final userTokens = await getIt.get<UserStorageService>().getTokens();

      var tokens = userTokens.fold(
        (l) => l.message,
        (r) => r,
      );
      if (tokens is UserTokens) {
        Logger().d(tokens.accessToken);
        final dio = getIt.get<Dio>();
        final response = await dio.get(
          '${data.getAllUserPosts}$userId?page=$page&take=9',
          options: Options(
            headers: {
              "Authorization": "Bearer ${tokens.accessToken}",
            },
          ),
        );
        Logger().d(response.data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final List<dynamic> jsonData = response.data;
          List<PostModel> posts =
              jsonData.map((data) => PostModel.fromJson(data)).toList();
          Logger().d(jsonData);

          return Right(posts);
        }
        return Left(AuthFailure.remote(message: response.toString()));
      }
    } catch (e) {
      print(e);
      return Left(AuthFailure.remote(message: e.toString()));
    }
    return null;
  }

  Future<Either<Failure, SetupProfileDataEntity>> deleteUserAvatar() async {
    try {
      final userTokens = await getIt.get<UserStorageService>().getTokens();
      var tokens = userTokens.fold(
        (l) => l.message,
        (r) => r,
      );

      if (tokens is UserTokens) {
        final response = await dio.patch(
          data.deleteUserAvatar,
          options: Options(
            headers: {
              "Authorization": "Bearer ${tokens.accessToken}",
            },
          ),
        );
        print(response.data);
        if (response.statusCode == 401 || response.statusCode == 500) {
          return Left(AuthFailure.remote(message: response.toString()));
        } else {
          return Right(
            SetupProfileDataEntity(
              photo: response.data['photo'],
              fullName: response.data['fullName'],
              nickname: response.data['nickname'],
              city: response.data['city'],
              bio: response.data['bio'],
            ),
          );
        }
      }
    } catch (e) {
      print(e);
      return Left(AuthFailure.remote(message: e.toString()));
    }
    return const Left(
        AuthFailure.remote(message: 'Failure on deleting user avatar'));
  }

  Future<Either<Failure, bool>> createPost(
    PostCreationModel postModel,
    String accessToken,
  ) async {
    try {
      print(postModel);
      print(data.createPost);
      final result = await dio.post(
        data.createPost,
        data: postModel.toJson(),
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (result.statusCode == 201) {
        return const Right(true);
      } else {
        print(result.statusCode);
        return const Left(GeneralFailure(message: 'Unexpected status code'));
      }
    } catch (e) {
      return const Left(GeneralFailure(message: 'Something went wrong'));
    }
  }
}
