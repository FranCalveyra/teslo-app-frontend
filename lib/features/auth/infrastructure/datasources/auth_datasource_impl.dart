import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/shared/infrastructure/mappers/mappers.dart';

import '../errors/errors.dart';
import '../mappers/mappers.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final Dio dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get(
        "/auth/check-status",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return UserMapper.userJsonToEntity(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(message: 'Invalid Token');
      }
      if (_isConnectionTimeout(e)) {
        throw CustomError(message: "Check Internet Connection");
      }

      throw Exception();
    } catch (e) {
      throw Exception();
    }
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
        throw ErrorMapper.customErrorFromDioException(e);
      }
      if (_isConnectionTimeout(e)) {
        throw CustomError(message: "Check Internet Connection");
      }

      throw Exception();
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
