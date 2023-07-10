import 'dart:io' show Platform;

class GoogleAuthServiceData {
  static const String _googleId =
      '690202184368-jo79e9jf775pp5vk714gto61nfhujoak.apps.googleusercontent.com';
  String get googleId => _googleId;

  static const String _iosApiKey = 'AIzaSyCOcWpg6JZMsapmqKlUr3GondMd27rztN4';
  String get iosApiKey => _iosApiKey;

  static const String _androidApiKey =
      'AIzaSyBLcSabnKNpScMLfPp219Zvwa-DAmsm7Jo';
  String get androidApiKey => _androidApiKey;

  static const String googleApisBaseUrl = "https://www.googleapis.com/";
  static const String peopleGoogleApisBaseUrl =
      "https://people.googleapis.com/";

  String get tokeninfo =>
      '${googleApisBaseUrl}oauth2/v3/tokeninfo?access_token';
  String get peopleInfo =>
      '${peopleGoogleApisBaseUrl}v1/people/me?key=${Platform.isIOS ? iosApiKey : androidApiKey}&personFields=names,birthdays';

  List<String> scopes = [
    'email',
    '${googleApisBaseUrl}auth/userinfo.profile',
    '${googleApisBaseUrl}auth/user.birthday.read',
    '${googleApisBaseUrl}auth/userinfo.email',
    '${googleApisBaseUrl}auth/plus.login',
  ];
}
