class MainServiceData {
  static const String baseUrl = "http://echo1.chisw.com/api";

  String get updateUser => '$baseUrl/users';

  String get getAllUserPosts => '$baseUrl/posts/user/';

  String get getCurrentUserInfo => '$baseUrl/users/user/currentUser';

  String get deleteUserAvatar => '$baseUrl/users/avatar';

  String get createPost => '$baseUrl/posts';
}
