import 'dart:io' show Platform;

class GoogleAuthServiceData {
  static const String _googleId = ''; // here should be readl google id
  String get googleId => _googleId;

  static const String _iosApiKey = ''; // here should be readl ios api key
  String get iosApiKey => _iosApiKey;

  static const String _androidApiKey =
      ''; // here should be readl android api key
  String get androidApiKey => _androidApiKey;

  static const String googleApisBaseUrl = "";
  static const String peopleGoogleApisBaseUrl = "";

  String get tokeninfo =>
      googleApisBaseUrl; // here should be readl endpoint for getting info by access token
  String get peopleInfo =>
      '${peopleGoogleApisBaseUrl}v1/people/me?key=${Platform.isIOS ? iosApiKey : androidApiKey}&personFields=names,birthdays';

  // defines scopes of google auth data erquest
  List<String> scopes = [
    'email',
    '${googleApisBaseUrl}auth/userinfo.profile',
    '${googleApisBaseUrl}auth/user.birthday.read',
    '${googleApisBaseUrl}auth/userinfo.email',
    '${googleApisBaseUrl}auth/plus.login',
  ];
}
