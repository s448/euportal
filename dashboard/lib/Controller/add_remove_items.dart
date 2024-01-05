import 'package:dashboard/Service/firebase_storage_services.dart';
import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/BusinessLogic/Services/Implementation/firestore_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firestore_services.dart';
import 'package:eup/Model/region_model.dart';
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
  }

  pickLogo() async {
    item.value.logo = await uploadImage('logo');
  }

  pickNewProductImage() async {
    item.value.portrait = await uploadImage('portrait');
  }

  uploadImage(String folder) => _imageUploadService.uploadImage(folder);
}
