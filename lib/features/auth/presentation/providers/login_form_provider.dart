import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/providers.dart';

import '../../../shared/shared.dart';

typedef LoginUserCallback = Future<void> Function(
    String email, String password);

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormStateNotifier, LoginFormState>(
        (ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  return LoginFormStateNotifier(loginUserCallback);
});

// Definitions
class LoginFormStateNotifier extends StateNotifier<LoginFormState> {
  final LoginUserCallback loginUserCallback;

  LoginFormStateNotifier(this.loginUserCallback) : super(LoginFormState());

  void onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email]),
    );
  }

  // Navigation shouldn't be this provider's responsibility
  void onFormSubmit() async {
    _touchAllFields();
    if (!state.isValid) return;
    await loginUserCallback(state.email.value, state.password.value);
  }

  void _touchAllFields() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password]),
    );
  }
}

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting:    $isPosting
    isFormPosted: $isFormPosted
    isValid:      $isValid
    email:        $email
    password:     $password
''';
  }
}
