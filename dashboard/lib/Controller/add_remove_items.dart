// ignore_for_file: invalid_use_of_protected_member

import 'dart:typed_data';

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

  Rx<Uint8List> logo = Rx<Uint8List>(Uint8List(0));
  Rx<Uint8List> portrait = Rx<Uint8List>(Uint8List(0));
  Rx<Uint8List> productImage = Rx<Uint8List>(Uint8List(0));

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
    item.value.logo = await uploadImage(logo.value, 'logo');
    item.value.portrait = await uploadImage(portrait.value, 'portrait');

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
    portrait.value = await _imageUploadService.pickImage();
    update();
  }

  pickLogo() async {
    logo.value = await _imageUploadService.pickImage();
    update();
  }

  pickNewProductImage() async {
    productImage.value = await _imageUploadService.pickImage();
    update();
  }

  Future<String?> uploadImage(Uint8List image, String folder) async {
    return await _imageUploadService.uploadImage(image, folder);
  }

  ///location lat & long
  RxString lat = ''.obs;
  RxString long = ''.obs;

  ///products
  RxString productImgUrl = ''.obs;
  RxString productTitle = ''.obs;

  addProduct() async {
    productImgUrl.value =
        (await uploadImage(productImage.value, 'restaurant_products')) ?? '';
    products?.value.add(
      Product(img: productImgUrl.value, title: productTitle.value),
    );
    productImage.value = Uint8List(0);
    productImgUrl.value = '';
    productTitle.value = '';
    update();
    Get.back();
  }

  RxList<Product>? products = <Product>[].obs;

  setLocationLat() =>
      item.value.location = ItemLocation(lat: lat.value, long: long.value);

  isRestaurantOrCoffeeShop() =>
      item.value.category?.id == "4" || item.value.category?.id == "1";

  isMosque() => item.value.category?.id == "2";
  isDr() => item.value.category?.id == "3";
}
