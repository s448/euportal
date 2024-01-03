import 'package:eup/BusinessLogic/Services/Implementation/home_page_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_home_page_services.dart';
import 'package:eup/Model/carousel_banner_model.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final IhomePageServices _services = HomePageServices();

  Stream<List<CarouselBanner>> get carouselStream => _services.carouselStream();
  Stream<List<Item>> get portratStream => _services.portratStream();
  Stream<List<Item>> get logoStream => _services.logoStream();
}
