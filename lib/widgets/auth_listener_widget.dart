import 'package:elendin_flutter/constants/enums.dart';
import 'package:elendin_flutter/locator.dart';
import 'package:elendin_flutter/router/app_route.dart';
import 'package:elendin_flutter/router/app_route.gr.dart';
import 'package:elendin_flutter/state_management/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthListenerWidget extends StatelessWidget {
  const AuthListenerWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.initial) {
          sl<AppRouter>().pushAndPopUntil(
            const LoginRoute(),
            predicate: (route) => false,
          );
        }        
      },
      child: child,
    );
  }
}
