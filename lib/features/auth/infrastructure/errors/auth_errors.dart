import 'package:teslo_shop/config/constants/constants.dart';

class WrongCredentials implements Exception {}

class ConnectionTimeout implements Exception {}

class InvalidToken implements Exception {}

class CustomError implements Exception {
  final String message;
  final int statusCode;

  CustomError({
    this.message = Constants.defaultErrorMessage,
    this.statusCode = Constants.defaultErrorCode,
  });
}
