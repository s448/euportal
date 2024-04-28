import 'package:eup/BusinessLogic/Services/Implementation/firebase_auth_service.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firebase_auth_service.dart';
import 'package:eup/Service/local_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final IFirebaseAuthService _authService = FirebaseAuthServiceImplementation();
  final _sharedPrefs = SharedPreferencesService();
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  isUserAuthenticated() {
    bool rememberMeResult = _sharedPrefs.isUserLoggedInAndRemembered();
    var currentUser = _authService.currentUser;
    print("the user ${currentUser?.email} ----- is $rememberMeResult");
    if (rememberMeResult == true && currentUser != null) {
      return true;
    }
    return false;
  }
}
