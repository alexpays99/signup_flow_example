import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:flutter/services.dart' show rootBundle;

class Parser {
  var logger = Logger();

  Parser._privateConstructor();
  static final Parser instance = Parser._privateConstructor();

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  Future<Map<String, dynamic>> decodeTermsData(String path) async {
    final fileInput = await getFileData(path);
    final terms = await jsonDecode(fileInput) as Map<String, dynamic>;
    logger.d(terms);
    return terms;
  }
}
