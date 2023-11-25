import 'package:eup/BusinessLogic/Services/Interface/i_home_page_services.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  IhomePageServices? _services;

  final RxString _country = ''.obs;
  final RxString _city = ''.obs;
  final RxString _category = ''.obs;

  List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  //setters for filters
  void setCountry(String? newValue) {
    _country.value = newValue ?? "";
  }

  void setCity(String? newValue) {
    _city.value = newValue ?? "";
  }

  void setCategory(String? newValue) {
    _category.value = newValue ?? "";
  }

  //getters for filters
  RxString getCountry() => _country;

  RxString getCity() => _city;

  RxString getCategory() => _category;

  //services
  getSearchResults(String q) async {
    return _services?.getSearchResult(q);
  }
}
