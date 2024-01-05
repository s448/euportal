// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:dashboard/Service/firebase_storage_services.dart';
import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/BusinessLogic/Services/Implementation/firestore_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firestore_services.dart';
import 'package:eup/Model/region_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_location_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/product_model.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ItemsController extends GetxController {
  final IFirestoreService _firestoreServices = FirestoreServices();
  final mainAppCtrl = Get.find<HomePageController>();

  Uuid uuid = const Uuid();

  Rx<Item> item = Rx<Item>(Item(id: ''));
  List<Region>? regions;
  @override
  void onInit() async {
    regions = await getRegions();
    super.onInit();
  }

  deleteItem(String id) => _firestoreServices.deleteDocument("selection", id);
  getCategories() => _firestoreServices.getCategories();
  getRegions() => _firestoreServices.getCategories();
  saveItem() async {
    var id = uuid.v1();
    item.value.id = id;
    setLocationLat();
    item.value.products = products?.value;
    print("${item.value.location?.lat} ------- ${item.value.location?.long}");
    if (await _firestoreServices.saveItem(item.value)) {
      Get.snackbar("Item saved successfully", "");
      Get.offAllNamed("/");
      item.value = Item(id: id);
    } else {
      Get.snackbar("Failed to save item", "");
    }
  }

  ///upload images
  // final ImagePicker _picker = ImagePicker();
  final ImageUploadService _imageUploadService = ImageUploadService();

  pickPortrait() async {
    item.value.portrait = await uploadImage('portrait');
    update();
  }

  pickLogo() async {
    item.value.logo = await uploadImage('logo');
    update();
    log(item.value.logo.toString());
  }

  pickNewProductImage() async {
    productImgUrl.value = await uploadImage('restaurant_products');
    update();
  }

  ///location lat & long
  RxString lat = ''.obs;
  RxString long = ''.obs;

  ///products
  RxString productImgUrl = ''.obs;
  RxString productTitle = ''.obs;

  addProduct() {
    products?.value.add(
      Product(img: productImgUrl.value, title: productTitle.value),
    );
    productImgUrl.value = '';
    productTitle.value = '';
    update();
    Get.back();
  }

  RxList<Product>? products = <Product>[].obs;

  setLocationLat() =>
      item.value.location = ItemLocation(lat: lat.value, long: long.value);

  Future<String> uploadImage(String folder) =>
      _imageUploadService.uploadImage(folder);

  isRestaurantOrCoffeeShop() =>
      item.value.category?.id == "4" || item.value.category?.id == "1";

  isMosque() => item.value.category?.id == "2";
  isDr() => item.value.category?.id == "3";
}
// final isRestaurantOrCoffeShop =
//     item.category?.id == "1" || item.category?.id == "4";

// final isMosque = item.category?.id == "2";
// final isDr = item.category?.id == "3";
