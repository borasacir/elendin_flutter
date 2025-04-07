part of 'auth_bloc.dart';

class AuthState {
  final AuthStatus status;
  final String email;
  final String password;
  final String confirmPassword;
  final InputError emailFieldError;
  final InputError passwordFieldError;
  final InputError confirmPasswordFieldError;

  AuthState(
      {this.status = AuthStatus.initial,
      this.email = '',
      this.password = '',
      this.confirmPassword = '',
      this.emailFieldError = InputError.none,
      this.passwordFieldError = InputError.none,
      this.confirmPasswordFieldError = InputError.none});

  AuthState copyWith(
      {AuthStatus? status,
      String? email,
      String? password,
      String? confirmPassword,
      InputError? emailFieldError,
      InputError? passwordFieldError,
      InputError? confirmPasswordFieldError}) {
    return AuthState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        emailFieldError: emailFieldError ?? this.emailFieldError,
        passwordFieldError: passwordFieldError ?? this.passwordFieldError,
        confirmPasswordFieldError:
            confirmPasswordFieldError ?? this.confirmPasswordFieldError);
  }
}
