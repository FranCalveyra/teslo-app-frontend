import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(AuthDatasource? datasource)
      : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(
      {required String email,
      required String fullName,
      required String password,
      required String repeatedPassword}) {
    return datasource.register(
      email: email,
      fullName: fullName,
      password: password,
      repeatedPassword: repeatedPassword,
    );
  }
}
