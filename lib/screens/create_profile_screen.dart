import 'package:auto_route/auto_route.dart';
import 'package:elendin_flutter/locator.dart';
import 'package:elendin_flutter/repository/profile_repository.dart';
import 'package:elendin_flutter/state_management/bloc/auth_bloc/auth_bloc.dart';
import 'package:elendin_flutter/widgets/text_fields/elendin_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 60, 24, 60),
        child: Column(
          children: [
            ElendinTextField(
              label: "Username",
              onChanged: (p0) {
                setState(() {
                  username = p0;
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (username != null) {
                    sl<ProfileRepository>()
                        .createProfileForNewUser(username: username!)
                        .then((value) {
                      if (value) {
                        BlocProvider.of<AuthBloc>(context)
                            .add(CompleteProfileCreation());
                      }
                    });
                  }
                },
                child: Text("Complete Profile Setup"))
          ],
        ),
      ),
    );
  }
}
