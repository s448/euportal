import 'package:eup/BusinessLogic/Services/Implementation/firebase_auth_service.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firebase_auth_service.dart';
import 'package:eup/Model/user_model.dart';
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
  var firstName = "".obs;
  var lastName = "".obs;
  var email = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;

  ///some extra Logic for UI state hanling
  var rememberMe = false.obs;
  var textObsecured = true.obs;

  ///object of the auth service page that contains all auth methodes
  ///and stream of user info
  final IFirebaseAuthService _authService = FirebaseAuthServiceImplementation();

  Stream<User?> get authStateChanges => _authService.authStateChanges;

  Future<bool> signInWithEmailAndPassword() => _authService
      .signInWithEmailAndPassword(email: email.value, password: password.value);

  Future<bool> createUserWithEmailAndPassword() async {
    return _authService.createUserWithEmailAndPassword(
      user: UserModel(
        email: email.value,
        firstName: firstName.value,
        lastName: lastName.value,
        id: uuid.v8(),
        profile: "",
        token: "",
      ),
      password: password.value,
    );
  }

  Future<bool> signOut() => _authService.signOut();
  Future<bool> sendResetPasswordLink() =>
      _authService.sendResetPasswordLink(email.value);

  ///buttons state identifiers
  RxBool isloginBtnLoading = false.obs;
  RxBool isSignUpBtnLoading = false.obs;
  RxBool isSignOutBtnLoading = false.obs;
  RxBool isGoogleLoading = false.obs;
  RxBool isFacebookLoading = false.obs;
  RxBool isXLoading = false.obs;

  changeObscureTextStatus() {
    textObsecured.value = !textObsecured.value;
    update();
  }
}
