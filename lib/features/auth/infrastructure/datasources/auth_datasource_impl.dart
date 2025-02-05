import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/constants.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/errors/auth_errors.dart';
import '../infrastructure.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final Dio dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) {
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final data = {"email": email, "password": password};
      final response = await dio.post("/auth/login", data: data);

      final user = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        final String message =
            e.response?.data["message"] ?? Constants.defaultErrorMessage;
        final int statusCode =
            e.response?.statusCode ?? Constants.defaultErrorCode;
        throw CustomError(message: message, statusCode: statusCode);
      }
      if (_isConnectionTimeout(e)) {
        throw CustomError(message: "Check Internet Connection");
      }

      throw CustomError();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(
      {required String email,
      required String fullName,
      required String password,
      required String repeatedPassword}) {
    // TODO: implement register
    throw UnimplementedError();
  }

  bool _isConnectionTimeout(DioException e) {
    return e.type == DioExceptionType.connectionTimeout;
  }
}
