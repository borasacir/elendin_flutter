import 'package:elendin_flutter/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elendin_flutter/models/user_profile_model.dart';
import 'package:flutter/material.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'users';

  /// Add a new user
  Future<bool> createUserProfile(
      {required UserModel user, required UserProfileModel profileModel}) async {
    try {
      await _firestore
          .collection(_collectionPath)
          .doc(user.userId)
          .set(profileModel.toJson());
      return true; // Return the document ID
    } catch (e) {
      debugPrint('Error adding profile: $e');
      return false;
    }
  }

  /// Get a user by ID
  Future<UserProfileModel?> getUserProfile({required UserModel user}) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection(_collectionPath).doc(user.userId).get();

      Map<String, dynamic> jsonData = {};
      if (docSnapshot.exists) {
        jsonData['username'] =
            (docSnapshot.data() as Map<String, dynamic>)['username'];
        jsonData['tropyCount'] =
            (docSnapshot.data() as Map<String, dynamic>)['tropyCount'] as int;
        jsonData['winStreak'] =
            (docSnapshot.data() as Map<String, dynamic>)['winStreak'] as int;

        return UserProfileModel.fromJson(jsonData);
      }

      return null;
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return null;
    }
  }

  /// Update a user's information
  Future<bool> updateUser(
      {required UserModel user,
      String? username,
      int? trophyCount,
      int? winStreak}) async {
    try {
      Map<String, dynamic> updateData = {};
      if (username != null) updateData['username'] = username;
      if (trophyCount != null) updateData['trophyCount'] = trophyCount;
      if (winStreak != null) updateData['winStreak'] = winStreak;

      await _firestore
          .collection(_collectionPath)
          .doc(user.userId)
          .update(updateData);
      return true;
    } catch (e) {
      debugPrint('Error updating user: $e');
      return false;
    }
  }

  /// Delete a user by ID
  Future<bool> deleteUser({required UserModel user}) async {
    try {
      await _firestore.collection(_collectionPath).doc(user.userId).delete();
      return true;
    } catch (e) {
      debugPrint('Error deleting user: $e');
      return false;
    }
  }
}
