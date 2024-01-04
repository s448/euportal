import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firestore_services.dart';
import 'package:eup/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices implements IFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> registerUser(User user) async {
    try {
      var userId = user.uid;
      UserModel userModel = UserModel(
        firstName: user.displayName,
        email: user.email,
        id: userId,
        profile: user.photoURL,
        token: "",
      );
      await _firestore.collection('users').doc(userId).set(userModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> saveUserData(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteDocument(String docPath, String docId) async {
    try {
      await _firestore.collection(docPath).doc(docId).delete();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
