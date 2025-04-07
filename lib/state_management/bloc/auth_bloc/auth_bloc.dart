import 'package:bloc/bloc.dart';
import 'package:elendin_flutter/constants/enums.dart';
import 'package:elendin_flutter/locator.dart';
import 'package:elendin_flutter/models/user_model.dart';
import 'package:elendin_flutter/repository/user_repository.dart';
import 'package:elendin_flutter/services/firebase_auth_service.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<LoginFormSubmission>(_onLoginFormSubmission);
    on<LoginRequestSubmission>(_onLoginRequestSubmission);
    on<LogOut>(_onLogOut);
    on<ResyncClaims>(_onResyncClaims);
    on<RegisterFormSubmission>(_onRegisterFormSubmission);
    on<RegisterRequestSubmission>(_onRegisterRequestSubmission);
    on<CompleteProfileCreation>(
      (event, emit) {
        emit(state.copyWith(status: AuthStatus.profileCreationCompleted));
      },
    );
    on<MissingProfile>(
      (event, emit) {
        emit(state.copyWith(status: AuthStatus.missingProfile));
      },
    );
  }

  AuthService authService = sl<AuthService>();

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(confirmPassword: event.password));
  }

  void _onLoginFormSubmission(
      LoginFormSubmission event, Emitter<AuthState> emit) {
    if (state.status == AuthStatus.inProgress) {
      return;
    }
    emit(state.copyWith(status: AuthStatus.inProgress));

    bool proceed = true;
    if (state.email.isEmpty) {
      emit(state.copyWith(emailFieldError: InputError.empty));

      proceed = false;
    } else if (!_validEmail(state.email)) {
      emit(state.copyWith(emailFieldError: InputError.invalid));
      proceed = false;
    } else if (state.password.isEmpty) {
      emit(state.copyWith(passwordFieldError: InputError.empty));
      proceed = false;
    }

    if (proceed) {
      add(LoginRequestSubmission());
    } else {
      emit(state.copyWith(status: AuthStatus.initial));
    }
  }

  Future<void> _onLoginRequestSubmission(
      LoginRequestSubmission event, Emitter<AuthState> emit) async {
    UserModel? user =
        await authService.login(email: state.email, password: state.password);

    if (user != null) {
      if (!user.emailVerified) {
        emit(state.copyWith(status: AuthStatus.verificationRequired));
      } else {
        emit(state.copyWith(status: AuthStatus.loggedIn));
      }
      sl<UserRepository>().saveUser(user);
    } else {
      emit(state.copyWith(status: AuthStatus.failed));
      // TODO: Handle Fail Login Event
    }
  }

  void _onRegisterFormSubmission(
      RegisterFormSubmission event, Emitter<AuthState> emit) {
    if (state.status == AuthStatus.inProgress) {
      return;
    }
    emit(state.copyWith(status: AuthStatus.inProgress));

    bool proceed = true;
    if (state.email.isEmpty) {
      emit(state.copyWith(emailFieldError: InputError.empty));
      proceed = false;
    } else if (!_validEmail(state.email)) {
      emit(state.copyWith(emailFieldError: InputError.invalid));
      proceed = false;
    } else if (state.password.isEmpty) {
      emit(state.copyWith(passwordFieldError: InputError.empty));
      proceed = false;
    } else if (state.confirmPassword.isEmpty) {
      emit(state.copyWith(confirmPasswordFieldError: InputError.empty));
      proceed = false;
    } else if (state.confirmPassword != state.password) {
      emit(state.copyWith(
          confirmPasswordFieldError: InputError.invalid,
          passwordFieldError: InputError.invalid));

      proceed = false;
    }
    if (proceed) {
      add(RegisterRequestSubmission());
    } else {
      emit(state.copyWith(status: AuthStatus.initial));
    }
  }

  Future<void> _onRegisterRequestSubmission(
      RegisterRequestSubmission event, Emitter<AuthState> emit) async {
    UserModel? user = await authService.signUpUser(
        email: state.email, password: state.password);

    if (user != null) {
      if (!user.emailVerified) {
        emit(state.copyWith(status: AuthStatus.verificationRequired));
      } else {
        emit(state.copyWith(status: AuthStatus.loggedIn));
      }
      sl<UserRepository>().saveUser(user);
    } else {
      emit(state.copyWith(status: AuthStatus.failed));
      // TODO: Handle Fail Login Event
    }
  }

  Future<void> _onResyncClaims(
      ResyncClaims event, Emitter<AuthState> emit) async {
    UserModel? updatedUser = await sl<AuthService>().resyncClaims();
    if (updatedUser != null) {
      if (!updatedUser.emailVerified) {
        emit(state.copyWith(status: AuthStatus.verificationRequired));
      } else {
        emit(state.copyWith(status: AuthStatus.loggedIn));
      }
      sl<UserRepository>().saveUser(updatedUser);
    }
  }

  void _onLogOut(LogOut event, Emitter<AuthState> emit) async {
    await sl<AuthService>().signOutUser();
    await sl<UserRepository>().clearUser();
    emit(AuthState());
  }

  bool _validEmail(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }
}
