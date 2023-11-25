import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';

abstract class IhomePageServices {
  Future<String> getSearchResult(String q);
  Stream<List<Category>> getSearchCategories();
}
