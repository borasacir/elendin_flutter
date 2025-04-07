import 'package:auto_route/auto_route.dart';
import 'package:elendin_flutter/constants/enums.dart';
import 'package:elendin_flutter/constants/sized_box_constants/sized_box_constants.dart';
import 'package:elendin_flutter/locator.dart';
import 'package:elendin_flutter/router/app_route.dart';
import 'package:elendin_flutter/router/app_route.gr.dart';
import 'package:elendin_flutter/screens/verification_screen.dart';
import 'package:elendin_flutter/state_management/bloc/auth_bloc/auth_bloc.dart';
import 'package:elendin_flutter/widgets/text_fields/elendin_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.loggedIn) {
          sl<AppRouter>().pushAndPopUntil(
            HomeRoute(),
            predicate: (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 60),
            child: state.status == AuthStatus.verificationRequired
                ? const VerificationScreen()
                : Column(
                    children: [
                      ElendinTextField(
                        label: "Email",
                        onChanged: (p0) {
                          BlocProvider.of<AuthBloc>(context)
                              .add(EmailChanged(email: p0));
                        },
                      ),
                      SizedBoxConstants.h12,
                      ElendinTextField(
                        label: "Password",
                        onChanged: (p0) {
                          BlocProvider.of<AuthBloc>(context)
                              .add(PasswordChanged(password: p0));
                        },
                      ),
                      ElendinTextField(
                        label: "Confirm Password",
                        onChanged: (p0) {
                          BlocProvider.of<AuthBloc>(context)
                              .add(ConfirmPasswordChanged(password: p0));
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(RegisterFormSubmission());
                          },
                          child: Text("Register")),
                      ElevatedButton(
                          onPressed: () {
                            sl<AppRouter>().pushAndPopUntil(
                              const LoginRoute(),
                              predicate: (route) => false,
                            );
                          },
                          child: Text("Already have an account? Login"))
                    ],
                  ),
          ),
        );
      },
    );
  }
}
