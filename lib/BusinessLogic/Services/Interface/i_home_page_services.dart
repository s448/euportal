import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/region_model.dart';
import 'package:eup/Model/search_item_model.dart';

abstract class IhomePageServices {
  Future<String> getSearchResult(String q);
  Future<List<Category>> getSearchCategories();
  Future<List<Region>> getRegions();
  Stream<List<Item>> portratStream();
  Stream<List<Item>> logoStream();
}
