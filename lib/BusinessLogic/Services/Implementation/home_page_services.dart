import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_home_page_services.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';

class HomePageServices implements IhomePageServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<String> getSearchResult(String q) async {
    return "this is result";
  }

  @override
  Stream<List<Category>> getSearchTypes() {
    return _firestore.collection('category').snapshots().map(
      (QuerySnapshot snapshot) {
        return snapshot.docs.map((DocumentSnapshot document) {
          final data = document.data() as Map<String, dynamic>;
          return Category.fromJson(data);
        }).toList();
      },
    );
  }
}
