import 'package:banner_carousel/banner_carousel.dart';
import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Model/carousel_banner_model.dart';
import 'package:eup/Service/url_launch_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCarousel extends StatelessWidget {
  const AppCarousel({super.key, required this.homePageController});
  final HomePageController homePageController;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: homePageController.carouselStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox();
        } else {
          List<CarouselBanner> casousels = snapshot.data!;
          List<Widget> banners = [];
          for (var element in casousels) {
            banners.add(
              //add widget
              InkWell(
                onTap: () => UrlLauncherService.launch(element.launchUrl ?? ""),
                child: SizedBox(
                  width: Get.width,
                  height: Get.height * 0.23,
                  child: Image.network(element.bannerUrl ?? ""),
                ),
              ),
            );
          }
          return BannerCarousel.fullScreen(
            height: Get.height * 0.14,
            customizedIndicators: const IndicatorModel.animation(
              width: 5,
              height: 5,
              spaceBetween: 2,
              widthAnimation: 5,
            ),
            customizedBanners: banners,
            activeColor: ColorManager.backgroundColor,
            disableColor: ColorManager.greyC,
            indicatorBottom: false,
          );
        }
      },
    );
  }
}

List<BannerModel> listBanners = [
  BannerModel(imagePath: testBanner, id: '1', boxFit: BoxFit.fill),
  BannerModel(imagePath: testBanner, id: '2', boxFit: BoxFit.fill),
  BannerModel(imagePath: testBanner, id: '3', boxFit: BoxFit.fill),
];
