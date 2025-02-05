import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/constants.dart';
import 'package:teslo_shop/features/auth/infrastructure/errors/errors.dart';

class ErrorMapper {
  static CustomError customErrorFromDioException(DioException e) {
    final message = e.response?.statusMessage ?? Constants.defaultErrorMessage;
    final statusCode = e.response?.statusCode ?? Constants.defaultErrorCode;
    return CustomError(message: message, statusCode: statusCode);
  }
}
