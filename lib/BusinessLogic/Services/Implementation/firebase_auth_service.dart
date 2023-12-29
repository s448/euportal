import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firebase_auth_service.dart';
import 'package:eup/Core/Utils/ExceptionHandling/firebase_auth_error_handler.dart';
import 'package:eup/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

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
      String errorMessage =
          FirebaseAuthErrorHandler.mapFirebaseAuthExceptionToMessage(e);
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
      String errorMessage =
          FirebaseAuthErrorHandler.mapFirebaseAuthExceptionToMessage(e);
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

  @override
  Future<bool> signInUsingTwitter() async {
    try {
      final twitterLogin = TwitterLogin(
        // Consumer API keys
        apiKey: 'JCFetzF0eQcziWxGcfiZ0lkao',
        // Consumer API Secret keys
        apiSecretKey: 'InlARLu46pkWg1rgwC02vrPruVg3WATcfyBRoxyPby0RYK2ip3',
        // Registered Callback URLs in TwitterApp
        // Android is a deeplink
        // iOS is a URLScheme
        redirectURI: 'https://euportal-bb198.firebaseapp.com/__/auth/handler',
      );
      final AuthResult authResult =
          await twitterLogin.loginV2(forceLogin: true);
      switch (authResult.status) {
        case TwitterLoginStatus.loggedIn:
          // success
          return true;
        case TwitterLoginStatus.cancelledByUser:
          // cancel
          log("message => ${authResult.errorMessage}");
          return false;
        case TwitterLoginStatus.error:
          // error
          log("message => ${authResult.errorMessage}");
          return false;
        case null:
          return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  signInUsingFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);
      final User user = userCredential.user!;

      if (facebookAuthCredential.accessToken == null) {
        return false;
      } else {
        ///if new user save it's info in firestore
        if (userCredential.additionalUserInfo!.isNewUser) {
          var userData = UserModel(
            email: user.email,
            id: user.uid,
            firstName: user.displayName,
            profile: user.photoURL,
            token: "",
          );
          await _firestore
              .collection("users")
              .doc(user.uid)
              .set(userData.toJson());
        }
      }
      return true;
    } catch (e) {
      log(e.toString());
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }
}
