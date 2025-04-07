import 'package:elendin_flutter/repository/profile_repository.dart';
import 'package:elendin_flutter/repository/user_repository.dart';
import 'package:elendin_flutter/router/app_route.dart';
import 'package:elendin_flutter/services/firebase_auth_service.dart';
import 'package:elendin_flutter/services/firebase_profile_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerSingleton<AppRouter>(AppRouter());
  sl.registerSingleton<AuthService>(AuthService());
  sl.registerSingleton<UserRepository>(UserRepository());
  sl.registerSingleton<ProfileService>(ProfileService());
  sl.registerSingleton<ProfileRepository>(ProfileRepository());
}
