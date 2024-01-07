import 'package:dashboard/Controller/home_controller.dart';
import 'package:dashboard/View/Screen/tabs/banner_ads/add_banner_page.dart';
import 'package:dashboard/View/Widget/banner_ad_grid_tile.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Model/carousel_banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerAdsTab extends StatelessWidget {
  BannerAdsTab({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double screenWidth = constraints.maxWidth;
      int crossAxisCount = (screenWidth / 200).floor();
      return SizedBox(
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 3,
              ),
              StreamBuilder(
                stream: controller.carouselStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No results"));
                  } else {
                    List<CarouselBanner> banners = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 1 / 1.2,
                        ),
                        itemCount: banners.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return InkWell(
                              onTap: () => Get.to(AddBannerPage()),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.primaryC,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add_location,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return BannerAdGridTile(
                              bannerAd: banners[index - 1],
                            );
                          }
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
