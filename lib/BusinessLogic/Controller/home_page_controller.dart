// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'package:eup/BusinessLogic/Services/Implementation/home_page_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_home_page_services.dart';
import 'package:eup/Core/Constant/app_name.dart';
import 'package:eup/Core/Utils/distance_calculator.dart';
import 'package:eup/Model/carousel_banner_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/region_model.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:eup/Service/location_service.dart';
import 'package:get/get.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:location/location.dart' hide Location;

class HomePageController extends GetxController {
  RxList<Category> categories = RxList<Category>();
  RxList<Region> regions = RxList<Region>();

  @override
  void onInit() async {
    // await getLocation();
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

  getFilterMode() => filterMode.value;

  final LocationService _locationService = LocationService();
  Rx<LocationData?> currentLocation = Rx<LocationData?>(null);

  Future<void> getLocation() async {
    currentLocation.value = await _locationService.getLocation();
  }

  double calculateDistance(String lat, String long) {
    Location target = Location(
      double.parse(lat),
      double.parse(lat),
    );
    LocationData? myLocationData = currentLocation.value;
    return DistanceCalculator.getDistance(
        Location(
            myLocationData?.latitude ?? 0.0, myLocationData?.longitude ?? 0.0),
        target);
  }

  Future<String> getAddress(String lat, String long) async {
    String address = await _locationService.getLocationAddress(
        double.parse(lat), double.parse(long));
    return address;
  }

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
    refresh();
  }

  isGridView() =>
      getCategory().value == "مطاعم" || getCategory().value == "مقاهي";

  isCenterTitle() =>
      viewIndex.value != 0 || getCategory().value != '' ? true : false;
  getAppTitle() {
    if (getCategory().value == '' && viewIndex.value == 0) {
      return appName;
    } else if (viewIndex.value == 1) {
      return "التفاصيل";
    } else {
      return 'قائمة ال${getCategory()}';
    }
  }

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
  // Item? viewedItem;
  incrementViewStackIndex() {
    //this method set the view model to details page which it's index is 1
    viewIndex.value++;
  }

  decrementViewIndex() {
    viewIndex.value--;
  }
}
