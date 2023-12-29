import 'package:eup/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseAuthService {
  User? get currentUser;

  Stream<User?> get authStateChanges;

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<bool> createUserWithEmailAndPassword(
      {required UserModel user, required String password});

  Future<bool> signOut();

  Future<bool> sendResetPasswordLink(String email);

  Future<bool> signInUsingTwitter();

  Future<bool> signInUsingFacebook();
}
