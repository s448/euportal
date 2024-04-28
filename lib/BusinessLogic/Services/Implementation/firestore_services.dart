import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firestore_services.dart';
import 'package:eup/Model/region_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/search_item_model.dart';
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
  Future<bool> saveUserData(UserModel userModel, String id) async {
    try {
      await _firestore.collection('users').doc(id).set({
        ...userModel.toJson(),
        'id': id,
      });
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

  @override
  Future<List<Category>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('category').get();

      List<Category> categories = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              Category.fromJson(doc.data()))
          .toList();

      return categories;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future<List<Region>> getRegions() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('region').get();

      List<Region> regions = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              Region.fromJson(doc.data()))
          .toList();

      return regions;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future<bool> saveItem(Item item) async {
    try {
      await _firestore.collection('selection').doc(item.id).set(item.toJson());
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<UserModel> getUserData(String id) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(id).get();

      if (docSnapshot.exists) {
        return UserModel.fromJson(docSnapshot as Map<String, dynamic>);
      } else {
        return UserModel();
      }
    } catch (e) {
      log('Error getting user data: $e');
      return UserModel();
    }
  }
}
