import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/features/feed/domain/entity/post/post_creation_entity.dart';

import '../entity/post/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>?> getAllUserPosts(
    String userId,
    String? page,
  );

  Future<Either<Failure, bool>> createPost(PostCreationEntity postEntity);
}
