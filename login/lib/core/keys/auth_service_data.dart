class AuthServiceData {
  static const String baseUrl =
      "https:amazonaws.com/"; // here should be real base url example
  String get signUpEndpoint => '${baseUrl}signUp';
  String get signInCredentialsEndpoint => '${baseUrl}signIn';
  String get validateAccessTokenEndpoint => '${baseUrl}validateToken';
  String get refreshTokensEndpoint => '${baseUrl}refreshToken';
  String get facebookLogin => '${baseUrl}facebookLogin';
  String get createCode => '${baseUrl}createCode';
  String get confirmCode => '${baseUrl}confirmCode';
  String get changePassword => '${baseUrl}changePassword';
  String get checkUserEmail => '${baseUrl}checkEmail';
  String get checkUserPhone => '${baseUrl}checkPhone';
  String get checkUserNickname => '${baseUrl}checkNickname';
  String get googleSignIn => '${baseUrl}googleSignIn';
}
