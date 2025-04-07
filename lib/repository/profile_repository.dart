import 'package:elendin_flutter/locator.dart';
import 'package:elendin_flutter/models/user_model.dart';
import 'package:elendin_flutter/models/user_profile_model.dart';
import 'package:elendin_flutter/repository/user_repository.dart';
import 'package:elendin_flutter/services/firebase_profile_service.dart';

class ProfileRepository {
  final ProfileService _service = sl<ProfileService>();
  late UserModel? currentUser;

  Future<bool> createProfileForNewUser({required String username}) async {
    currentUser = await sl<UserRepository>().getCurrentUser();
    if (currentUser == null) {
      return false;
    }

    return await _service.createUserProfile(
        user: currentUser!, profileModel: UserProfileModel(username: username));
  }

  Future<UserProfileModel?> getUserProfile() async {
    currentUser = await sl<UserRepository>().getCurrentUser();
    if (currentUser == null) {
      return null;
    }

    return _service.getUserProfile(user: currentUser!);
  }

  Future<bool> updateUserProfile(
      {String? username, int? trophyCount, int? winStreak}) async {
    currentUser = await sl<UserRepository>().getCurrentUser();
    if (currentUser == null) {
      return false;
    }

    return await _service.updateUser(user: currentUser!);
  }
}
