part of 'user_page_cubit.dart';

@freezed
class UserPageState with _$UserPageState {
  const factory UserPageState({
    PostListStateModel? postListStateModel,
    CurrentUserStateModel? currentUserStateModel,
  }) = _UserPageState;
}
