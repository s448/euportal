import 'package:eup/BusinessLogic/Services/Implementation/home_page_services.dart';
import 'package:eup/BusinessLogic/Services/Implementation/region_services_implemntation.dart';

import 'package:eup/BusinessLogic/Services/Interface/i_home_page_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_region_services.dart';

import 'package:eup/Model/region_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegionsController extends GetxController {
  // final IhomePageServices _services = HomePageServices();
  final IRegionService _regionService = RegionServiceImplementation();
  Stream<List<Region>> get getRegions => _regionService.regionsStream();
  deleteRegion(String id) => _regionService.deleteRegion(id);

  TextEditingController countryField = TextEditingController();
  TextEditingController citiesField = TextEditingController();

  Rx<Region> region = Rx(Region());
  RxString country = ''.obs;
  RxString cities = ''.obs;

  splitCities() => region.value.cities = cities.split(',');

  saveRegion() async {
    countryField.clear();
    citiesField.clear();
    splitCities();
    region.value.country = country.value;
    await _regionService.addRegion(region.value);
    country.value = '';
    cities.value = '';
  }
}
