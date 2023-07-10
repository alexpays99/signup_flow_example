abstract class RegexpRules {
  ///r'^
  ///(?=.*[A-Z])       // should contain at least one upper case
  ///(?=.*[a-z])       // should contain at least one lower case
  ///(?=.*?[0-9])      // should contain at least one digit
  ///(?=.*?[!@#\$&*~]) // should contain at least one Special character
  ///.{8,}             // Must be at least 8 characters in length
  ///$

  static RegExp hasEightCharacters = RegExp(r'^.{8,20}$');
  static RegExp hasUppercase = RegExp(r'[A-Z]');
  static RegExp hasLowercase = RegExp(r'[a-z]');
  static RegExp hasDigit = RegExp(r'[0-9]');
  static RegExp hasSpecialCharacter = RegExp(r'[-!@#\$&*~_"]');
  static RegExp hasCyrylic = RegExp(r'[а-яА-Я]');
  static RegExp hasAllowedNameCharacters = RegExp(r"^[a-zA-Zа-яА-Я\s\']+$");
  static RegExp confirmationCodeValidator = RegExp(r'^([0-9]){6}$');
  static RegExp hasEmodji = RegExp(r'[^\x00-\x7F]+');

  static RegExp passwordRegEx = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-]).{8,24}$');

  // include cyrylic, numbers and special characters
  static RegExp nicknameRegexp =
      RegExp(r'^[\p{Latin}\p{Punctuation}\p{Symbol}]+$');
  // only cyrylic characters
  static RegExp nameRegEx = RegExp(r'^(?=.*?[a-zA-Zа-яА-Я ’-]).{2,35}$');
  static RegExp hasNameSpecialCharacter = RegExp(r'[!@#\$&*~_"(){}+=;:^%]');
}
