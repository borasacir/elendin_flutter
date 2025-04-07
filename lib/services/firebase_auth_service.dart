import 'package:elendin_flutter/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return userCredential.user == null
          ? null
          : UserModel(
              userId: userCredential.user!.uid,
              email: userCredential.user!.email,
              displayName: userCredential.user!.displayName,
              emailVerified: userCredential.user!.emailVerified);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        return null;
      } else {
        debugPrint(e.message);
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// create user
  Future<UserModel?> signUpUser(
    {required String email,
    required String password,}
  ) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return UserModel(
            userId: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            displayName: firebaseUser.displayName ?? '',
            emailVerified: firebaseUser.emailVerified);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  ///signOutUser
  Future<void> signOutUser() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      await _firebaseAuth.signOut();
    }
  }

  Future<UserModel?> resyncClaims() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      await firebaseUser.reload();
      return UserModel(
          userId: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName ?? '',
          emailVerified: firebaseUser.emailVerified);
    }
    return null;
  }

  Future<void> sendEmailVerificationLink() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      await firebaseUser.sendEmailVerification();
    }
  }
}
