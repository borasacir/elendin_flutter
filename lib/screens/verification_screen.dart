import 'dart:async';

import 'package:elendin_flutter/locator.dart';
import 'package:elendin_flutter/services/firebase_auth_service.dart';
import 'package:elendin_flutter/state_management/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    sl<AuthService>().sendEmailVerificationLink();

    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      context.read<AuthBloc>().add(ResyncClaims());
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text('Please verify your email address.'),
        ElevatedButton(
            onPressed: () {
              sl<AuthService>().sendEmailVerificationLink();
            },
            child: Text("Resend email"))
      ]),
    );
  }
}
