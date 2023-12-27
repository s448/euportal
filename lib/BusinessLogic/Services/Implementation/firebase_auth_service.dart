import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firebase_auth_service.dart';
import 'package:eup/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServiceImplementation implements IFirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> createUserWithEmailAndPassword(
      {required UserModel user, required String password}) async {
    try {
      ///create a new user with these email and password
      await _auth.createUserWithEmailAndPassword(
          email: user.email ?? "", password: password);

      ///save user info to the firestore with
      await _firestore.collection('users').doc(user.id).set(user.toJson());
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> sendResetPasswordLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
