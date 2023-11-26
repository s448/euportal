// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'package:eup/BusinessLogic/Services/Implementation/home_page_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_home_page_services.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/region_model.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  RxList<Category> categories = RxList<Category>();
  RxList<Region> regions = RxList<Region>();

  @override
  void onInit() async {
    categories.value = await getCategories();
    regions.value = await getRegions();
    super.onInit();
  }

  final IhomePageServices _services = HomePageServices();

  final RxString _country = ''.obs;
  final RxString _city = ''.obs;
  final RxString _category = ''.obs;
  final Rx<Region> selectedRegion = Rx<Region>(Region());

  //setters for filters
  void setCountry(String? newValue) {
    setRegion(newValue ?? "");
    _country.value = newValue ?? "";
  }

  void setRegion(String? newValue) {
    selectedRegion.value =
        regions.where((region) => region.country == newValue).first;
    log(selectedRegion.value.cities!.first.toString());
  }

  void setCity(String? newValue) {
    _city.value = newValue ?? "";
  }

  void setCategory(String? newValue) {
    _category.value = newValue ?? "";
  }

  clearCity() => _city.value = '';

  //getters for filters
  RxString getCountry() => _country;

  RxString getCity() => _city;

  RxString getCategory() => _category;

  //services

  Future<List<Category>> getCategories() {
    return _services.getSearchCategories();
  }

  Future<List<Region>> getRegions() {
    return _services.getRegions();
  }

  final RxList<Item> items = <Item>[].obs;

  Stream<List<Item>> get portratStream => _services.portratStream();
  Stream<List<Item>> get logoStream => _services.logoStream();
}
