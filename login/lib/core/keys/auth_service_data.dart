class AuthServiceData {
  static const String baseUrl =
      "https://2l8kei2uz4.execute-api.eu-west-3.amazonaws.com/";
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
