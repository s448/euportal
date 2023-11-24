import 'package:banner_carousel/banner_carousel.dart';
import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCarousel extends StatelessWidget {
  const AppCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BannerCarousel.fullScreen(
      height: Get.height * 0.15,
      banners: listBanners,
      customizedIndicators: const IndicatorModel.animation(
        width: 5,
        height: 5,
        spaceBetween: 2,
        widthAnimation: 5,
      ),
      activeColor: ColorManager.backgroundColor,
      disableColor: ColorManager.greyC,
      indicatorBottom: false,
    );
  }
}

List<BannerModel> listBanners = [
  BannerModel(imagePath: testBanner, id: '1', boxFit: BoxFit.fill),
  BannerModel(imagePath: testBanner, id: '2', boxFit: BoxFit.fill),
  BannerModel(imagePath: testBanner, id: '3', boxFit: BoxFit.fill),
];
