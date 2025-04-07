import 'package:auto_route/auto_route.dart';
import 'package:elendin_flutter/constants/enums.dart';
import 'package:elendin_flutter/constants/sized_box_constants/sized_box_constants.dart';
import 'package:elendin_flutter/locator.dart';
import 'package:elendin_flutter/models/user_model.dart';
import 'package:elendin_flutter/models/user_profile_model.dart';
import 'package:elendin_flutter/repository/profile_repository.dart';
import 'package:elendin_flutter/repository/user_repository.dart';

import 'package:elendin_flutter/screens/create_profile_screen.dart';
import 'package:elendin_flutter/state_management/bloc/auth_bloc/auth_bloc.dart';
import 'package:elendin_flutter/widgets/auth_listener_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  late final UserModel activeUser;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  String? userId;
  String? username;
  int? trophyCount;
  int? winStreak;

  @override
  void initState() {
    super.initState();
    sl<UserRepository>().getCurrentUser().then((user) {
      if (user != null) {
        setState(() {
          userId = user.userId;
          name = user.displayName;
        });
      }
    });

    sl<ProfileRepository>().getUserProfile().then((profile) {
      if (profile != null) {
        setState(() {
          username = profile.username;
          trophyCount = profile.tropyCount;
          winStreak = profile.winStreak;
        });
      } else {
        BlocProvider.of<AuthBloc>(context).add(MissingProfile());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthListenerWidget(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.status == AuthStatus.missingProfile
              ? CreateProfileScreen()
              : Scaffold(
                  body: Center(
                    child: Column(
                      children: [
                        SizedBoxConstants.h50,
                        ElevatedButton(
                          child: Text("Get Current User Information"),
                          onPressed: () async {
                            UserModel? user =
                                await sl<UserRepository>().getCurrentUser();
                            if (user != null) {
                              setState(() {
                                userId = user.userId;
                                name = user.displayName;
                              });
                            }

                            UserProfileModel? profile =
                                await sl<ProfileRepository>().getUserProfile();
                            if (profile != null) {
                              setState(() {
                                username = profile.username;
                                trophyCount = profile.tropyCount;
                                winStreak = profile.winStreak;
                              });
                            } else {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(MissingProfile());
                            }
                          },
                        ),
                        Text("User id: ${userId ?? 'undefined'}"),
                        Text('Username: ${username ?? 'undefined'}'),
                        Text('Trophy Count: ${trophyCount.toString()}'),
                        Text('Win streak: ${winStreak.toString()}'),
                        ElevatedButton(
                          child: Text("LogOut"),
                          onPressed: () async {
                            BlocProvider.of<AuthBloc>(context).add(LogOut());
                          },
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
