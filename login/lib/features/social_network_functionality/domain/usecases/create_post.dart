import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/features/feed/domain/entity/post/post_creation_entity.dart';
import 'package:login/features/feed/domain/repository/post_repository.dart';

class CreatePost extends UseCase<bool, PostCreationEntity> {
  final PostRepository postRepository;

  CreatePost({
    required this.postRepository,
  });

  @override
  Future<Either<Failure, bool>> call(PostCreationEntity params) async {
    return await postRepository.createPost(params);
  }
}
