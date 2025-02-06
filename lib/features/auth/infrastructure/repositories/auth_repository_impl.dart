import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/datasources/datasources.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl([AuthDatasource? datasource])
      : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> checkAuthStatus(String token) async {
    return await datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) async {
    return await datasource.login(email, password);
  }

  @override
  Future<User> register(
      {required String email,
      required String fullName,
      required String password,
      required String repeatedPassword}) async {
    return await datasource.register(
      email: email,
      fullName: fullName,
      password: password,
      repeatedPassword: repeatedPassword,
    );
  }
}
