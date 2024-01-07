import 'package:eup/Model/carousel_banner_model.dart';

abstract class IBannerServices {
  deleteBanner(String id);
  saveBanner(CarouselBanner banner);
}
