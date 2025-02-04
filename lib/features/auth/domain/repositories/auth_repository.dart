import '../entities/entities.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register({
    required String email,
    required String fullName,
    required String password,
    required String repeatedPassword,
  });

  Future<User> checkAuthStatus(String token);
}
