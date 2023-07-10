import 'package:login/core/domain/entity/failure.dart';
import 'package:login/features/auth/domain/entity/auth_failure.dart';

import 'package:dartz/dartz.dart';
import 'package:login/features/feed/domain/entity/post/post_creation_entity.dart';
import 'package:login/features/social_network_functionality/data/models/post_creation_model.dart';

import '../../../../core/servises/main_service.dart';
import '../../../auth/sevices/user_storage_service.dart';
import '../../domain/entity/post/post_entity.dart';
import '../../domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final UserStorageService userStorage;
  final MainService mainService;

  PostRepositoryImpl({
    required this.userStorage,
    required this.mainService,
  });

  @override
  Future<Either<AuthFailure, List<PostEntity>>?> getAllUserPosts(
      String userId, String? page) async {
    try {
      final userPosts = await mainService.getAllUserPosts(userId, page);
      if (userPosts != null) {
        return userPosts.fold(
          (l) => Left(AuthFailure.local(message: l.message)),
          (r) {
            final result = r.map((e) => e.entity).toList();
            return Right(result);
          },
        );
      }
    } catch (e) {
      return const Left(AuthFailure.local(message: 'Something went wrong'));
    }
    return null;
  }

  @override
  Future<Either<Failure, bool>> createPost(
    PostCreationEntity postEntity,
  ) async {
    final tokens = await userStorage.getTokens();
    return await tokens.fold(
      (l) => Left(l),
      (r) async {
        final result = await mainService.createPost(
          PostCreationModel.fromEntity(postEntity),
          r.accessToken,
        );
        return result;
      },
    );
  }
}
