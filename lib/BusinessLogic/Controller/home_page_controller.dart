// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'package:eup/BusinessLogic/Services/Implementation/home_page_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_home_page_services.dart';
import 'package:eup/Model/carousel_banner_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/region_model.dart';
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

  RxBool filterMode = false.obs;

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
    filterMode.value = true;
    _category.value = newValue ?? "";
  }

  isGridView() =>
      getCategory().value == "مطاعم" || getCategory().value == "مقاهي";

  isCenterTitle() =>
      viewIndex.value != 0 || getCategory().value != '' ? true : false;
  getAppTitle() {
    if (getCategory().value == '' && viewIndex.value == 0) {
      return 'بوابة الإتحاد الأوروبي';
    } else if (viewIndex.value == 1) {
      return "التفاصيل";
    } else {
      return 'قائمة ال${getCategory()}';
    }
  }

  // defineHomePageTitle(){
  //   switch (getCategory().value) {
  //     case "مطاعم":
  //       return ""
  //     default:
  //   }
  // }

  resetMode() {
    viewIndex.value = 0;
    filterMode.value = false;
    _category.value = '';
    _country.value = '';
    clearCity();
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

  Stream<List<CarouselBanner>> get carouselStream => _services.carouselStream();
  Stream<List<Item>> get portratStream => _services.portratStream();
  Stream<List<Item>> get logoStream => _services.logoStream();
  Stream<List<Item>> get filterStream =>
      _services.filterStream(_country.value, _city.value, _category.value);

  RxInt viewIndex = 0.obs;
  Item? viewedItem;
  viewItemDetails(Item item) {
    viewIndex.value = 1;
    viewedItem = item;
  }
}
