import 'dart:developer';

import 'package:eup/BusinessLogic/Services/Implementation/firestore_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firebase_auth_service.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firestore_services.dart';
import 'package:eup/Core/Utils/ExceptionHandling/firebase_auth_error_handler.dart';
import 'package:eup/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

class FirebaseAuthServiceImplementation implements IFirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final IFirestoreService _firestore = FirestoreServices();
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
      if (await _firestore.saveUserData(user)) {
        return true;
      } else {
        return false;
      }
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
          ///save user data to firestore
          var usr = authResult.user;
          if (await _firestore.saveUserData(UserModel(
            email: usr?.email,
            firstName: usr?.name,
            id: usr!.id.toString(),
            profile: usr.thumbnailImage,
            token: "",
          ))) {
            return true;
          } else {
            return false;
          }
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
      var userCredential = await signInUsingCredentials(facebookAuthCredential);
      final User user = userCredential.user!;

      if (facebookAuthCredential.accessToken == null) {
        return false;
      } else {
        ///if new user save it's info in firestore
        if (userCredential.additionalUserInfo!.isNewUser) {
          if (await _firestore.registerUser(user)) {
            return true;
          } else {
            return false;
          }
        } else {
          return true;
        }
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  @override
  Future<bool> signInUsingGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuth =
          await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth?.accessToken,
        idToken: googleSignInAuth?.idToken,
      );

      var userCredential = await signInUsingCredentials(credential);
      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          if (await _firestore.registerUser(user)) {
            return true;
          } else {
            return false;
          }
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  signInUsingCredentials(AuthCredential credential) async {
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential;
  }

  @override
  signInAsAdmin({required String email, required String password}) async {
    try {
      var userCredentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredentials.user?.email == "eu.gate.ar@gmail.com") {
        return true;
      } else {
        Get.snackbar("User not authorized", '');
        return false;
      }
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
}
