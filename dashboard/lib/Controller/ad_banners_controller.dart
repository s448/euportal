import 'package:get/get.dart';
import 'package:eup/BusinessLogic/Services/Implementation/banner_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_banners_services.dart';

class AdBannersController extends GetxController {
  final IBannerServices _services = BannerServiceImplementation();

  deleteBanner(String id) => _services.deleteBanner(id);
}
