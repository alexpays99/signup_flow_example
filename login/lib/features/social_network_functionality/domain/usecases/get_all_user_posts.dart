import 'package:dartz/dartz.dart';
import 'package:login/core/domain/entity/failure.dart';
import 'package:login/core/domain/usecase/usecase.dart';
import 'package:login/features/auth/domain/entity/auth_failure.dart';

import '../../../auth/domain/repository/user_repository.dart';
import '../../../feed/domain/entity/post/post_entity.dart';
import '../../../feed/domain/repository/post_repository.dart';

class GetAllUserPosts extends UseCase<List<PostEntity>, String?> {
  final PostRepository postRepository;
  final UserRepository userRepository;

  GetAllUserPosts({
    required this.postRepository,
    required this.userRepository,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> call([String? params]) async {
    try {
      final userData = await userRepository.getUser();

      return userData.fold(
        (l) => Left(l),
        (r) async {
          final postRepoResult =
              await postRepository.getAllUserPosts(r.id, params) ??
                  const Left(AuthFailure.remote(message: 'Something wrong'));
          return postRepoResult.fold(
            (l) => Left(l),
            (r) => Right(r),
          );
        },
      );
    } catch (e) {
      return Left(AuthFailure.remote(message: e.toString()));
    }
  }
}
