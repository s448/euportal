import 'package:eup/Model/region_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:eup/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirestoreService {
  Future<bool> registerUser(User user);
  Future<bool> saveUserData(UserModel userModel);
  Future<bool> deleteDocument(String docPath, String docId);
  Future<List<Category>> getCategories();
  Future<List<Region>> getRegions();
  Future<bool> saveItem(Item item);
}
