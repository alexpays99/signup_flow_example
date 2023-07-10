import 'package:login/features/feed/domain/entity/post/post_entity.dart';

enum PostListState {
  initial,
  loading,
  loaded,
  error,
}

class PostListStateModel {
  List<PostEntity>? value;
  int? page;
  PostListState? postListState;
  String? message;

  PostListStateModel({
    this.value,
    this.page,
    required this.postListState,
    this.message,
  });
}
