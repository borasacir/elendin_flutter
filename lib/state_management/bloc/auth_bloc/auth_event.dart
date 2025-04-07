part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class EmailChanged extends AuthEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

final class PasswordChanged extends AuthEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

final class ConfirmPasswordChanged extends AuthEvent {
  const ConfirmPasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginFormSubmission extends AuthEvent {}

final class LogOut extends AuthEvent {}

final class LoginRequestSubmission extends AuthEvent {}

final class RegisterFormSubmission extends AuthEvent {}

final class RegisterRequestSubmission extends AuthEvent {}

final class ResyncClaims extends AuthEvent {}

final class CompleteProfileCreation extends AuthEvent {}

final class MissingProfile extends AuthEvent {}