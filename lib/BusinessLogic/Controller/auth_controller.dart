import 'dart:developer';

import 'package:eup/BusinessLogic/Services/Implementation/firebase_auth_service.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firebase_auth_service.dart';
import 'package:eup/Model/user_model.dart';
import 'package:eup/Service/local_storage_service.dart';
import 'package:eup/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AuthController extends GetxController {
  ///form keys for the 3 auth pages
  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  ///User id generator
  var uuid = const Uuid();

  ///text fields parameters
  final _firstName = "".obs;
  final _lastName = "".obs;
  final _email = "".obs;
  final _password = "".obs;
  final _confirmPassword = "".obs;

  // Getters
  String get getFirstName => _firstName.value;
  String get getLastName => _lastName.value;
  String get getEmail => _email.value;
  String get getPassword => _password.value;
  String get getConfirmPassword => _confirmPassword.value;

  // Setters
  set setFirstName(String value) => _firstName.value = value;
  set setLastName(String value) => _lastName.value = value;
  set setEmail(String value) => _email.value = value;
  set setPassword(String value) => _password.value = value;
  set setConfirmPassword(String value) => _confirmPassword.value = value;

  ///some extra Logic for UI state hanling
  var rememberMe = false.obs;
  var textObsecured = true.obs;

  ///object of the auth service page that contains all auth methodes
  ///and stream of user info
  final IFirebaseAuthService _authService = FirebaseAuthServiceImplementation();
  final _sharedPrefs = SharedPreferencesService();

  Stream<User?> get authStateChanges => _authService.authStateChanges;

  Future<bool> signInWithEmailAndPassword() async {
    signInBtnLoading.value = true;
    if (loginFormKey.currentState!.validate()) {
      var result = await _authService.signInWithEmailAndPassword(
          email: getEmail, password: getPassword);
      if (rememberMe.value) {
        await saveUserAuthState(result);
      }
      if (result) {
        Get.offAllNamed(Routes.navbar);
      }
      signInBtnLoading.value = false;
      return result;
    } else {
      signInBtnLoading.value = false;
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword() async {
    signInBtnLoading.value = true;
    if (registerFormKey.currentState!.validate()) {
      log(getFirstName);
      log(getLastName);
      log(getEmail);
      log(getPassword);
      log(getConfirmPassword);

      var result = await _authService.createUserWithEmailAndPassword(
        user: UserModel(
          email: getEmail,
          firstName: getFirstName,
          lastName: getLastName,
          id: uuid.v8(),
          profile: "",
          token: "",
        ),
        password: getPassword,
      );
      if (rememberMe.value) {
        await saveUserAuthState(result);
      }
      if (result) {
        Get.offAllNamed(Routes.navbar);
      }
      signInBtnLoading.value = false;
      return result;
    } else {
      signInBtnLoading.value = false;
      return false;
    }
  }

  Future<bool> signOut() => _authService.signOut();
  Future<bool> sendResetPasswordLink() =>
      _authService.sendResetPasswordLink(getEmail);

  ///buttons state identifiers
  RxBool signInBtnLoading = false.obs;
  RxBool isSignOutBtnLoading = false.obs;
  RxBool isGoogleLoading = false.obs;
  RxBool isFacebookLoading = false.obs;
  RxBool isXLoading = false.obs;

  ///the UI is triggered between Sign up or Login according to this flag
  RxBool isLogin = false.obs;

  changeObscureTextStatus() {
    textObsecured.value = !textObsecured.value;
    update();
  }

  flipRememberMe(val) => rememberMe.value = val;

  matchPasswords() => getPassword == getConfirmPassword;

  saveUserAuthState(bool flag) async {
    await _sharedPrefs.saveBool('remember_me', flag);
  }
}
