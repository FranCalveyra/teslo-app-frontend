import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/infrastructure/repositories/auth_repository_impl.dart';

import '../../domain/domain.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(repository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository repository;

  AuthNotifier({required this.repository}) : super(AuthState());

  void loginUser(String email, String password) async {
    // final user = await repository.login(email, password);
    // state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
  }

  void registerUser(String email, String password, String fullName) async {
    // final user = await repository.register(
    //     email: email,
    //     fullName: fullName,
    //     password: password,
    //     repeatedPassword: password);
    // state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
  }

  void checkAuthStatus() async {}
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
