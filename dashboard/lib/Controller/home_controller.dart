import 'package:eup/BusinessLogic/Services/Implementation/firestore_services.dart';
import 'package:eup/BusinessLogic/Services/Implementation/home_page_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_firestore_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_home_page_services.dart';
import 'package:eup/Model/carousel_banner_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    categories = await getCategories();
    super.onInit();
  }

  Uuid uuid = const Uuid();

  Item? item;
  List<Category>? categories;

  final IhomePageServices _services = HomePageServices();
  final IFirestoreService _firestoreServices = FirestoreServices();

  Stream<List<CarouselBanner>> get carouselStream => _services.carouselStream();
  Stream<List<Item>> get portratStream => _services.portratStream();
  Stream<List<Item>> get logoStream => _services.logoStream();

  deleteItem(String id) => _firestoreServices.deleteDocument("selection", id);
  getCategories() => _firestoreServices.getCategories();
}
