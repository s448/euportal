import 'package:dashboard/View/Screen/login_page.dart';
import 'package:dashboard/View/Screen/side_bar.dart';
import 'package:eup/BusinessLogic/Services/Implementation/firebase_auth_service.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firebase_auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DashboardAuthController extends GetxController {
  final IFirebaseAuthService _authService = FirebaseAuthServiceImplementation();

  RxString email = ''.obs;
  RxString password = ''.obs;

  RxBool isLoginLoading = false.obs;

  final loginFormKey = GlobalKey<FormState>();

  login() async {
    if (loginFormKey.currentState!.validate()) {
      isLoginLoading.value = true;
      var result = await _authService.signInAsAdmin(
          email: email.value, password: password.value);
      if (result) {
        Get.offAll(const SideBarPage());
      }
      isLoginLoading.value = false;
    }
  }

  logout() async {
    var result = await _authService.signOut();
    if (result) {
      Get.offAll(LoginPage());
    } else {
      Get.snackbar("Failed to log out", "please, try again");
    }
  }
}
