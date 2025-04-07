import 'dart:convert';
import 'package:elendin_flutter/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserRepository {
  static const String _userKey = 'active_user';

  // Save user information
  Future<void> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }

    return null; // No user data found
  }

  // Update user information
  Future<void> updateUser(UserModel updatedUser) async {
    await saveUser(updatedUser);
  }

  // Clear user data
  Future<void> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
