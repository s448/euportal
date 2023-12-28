import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firebase_auth_service.dart';
import 'package:eup/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthServiceImplementation implements IFirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      String errorMessage = _mapFirebaseAuthExceptionToMessage(e);
      Get.snackbar('خطأ', errorMessage, snackPosition: SnackPosition.BOTTOM);
      return false;
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع',
          snackPosition: SnackPosition.BOTTOM);
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
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      String errorMessage = _mapFirebaseAuthExceptionToMessage(e);
      Get.snackbar('خطأ', errorMessage, snackPosition: SnackPosition.BOTTOM);
      return false;
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع',
          snackPosition: SnackPosition.BOTTOM);
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

  // Map FirebaseAuthException codes to user-friendly error messages
  String _mapFirebaseAuthExceptionToMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'email-already-in-use':
        return 'عنوان البريد الإلكتروني قيد الاستخدام بالفعل من قبل حساب آخر.';
      case 'invalid-email':
        return 'عنوان البريد الإلكتروني غير صالح.';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً.';
      case 'user-not-found':
        return 'لا يوجد مستخدم لهذا البريد الإلكتروني.';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة لهذا المستخدم.';
      case 'invalid-credential':
        return 'الاعتمادات غير صحيحة. يرجى التحقق من صحة البريد الإلكتروني وكلمة المرور.';
      default:
        return 'فشلت عملية المصادقة. يرجى المحاولة مرة أخرى.';
    }
  }
}
