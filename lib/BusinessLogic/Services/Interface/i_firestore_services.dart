import 'package:eup/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirestoreService {
  Future<bool> registerUser(User user);
  Future<bool> saveUserData(UserModel userModel);
  Future<bool> deleteDocument(String docPath, String docId);
}
