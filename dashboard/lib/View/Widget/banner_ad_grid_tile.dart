import 'package:dashboard/Controller/home_controller.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/carousel_banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerAdGridTile extends StatelessWidget {
  BannerAdGridTile({super.key, required this.bannerAd});
  final CarouselBanner bannerAd;
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: ColorManager.primaryC),
      ),
      // height: Get.height * 0.6,primaryColorLight
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.1)),
              width: double.infinity,
              height: Get.height * 0.13,
              child: Image.network(
                bannerAd.bannerUrl.toString(),
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              bannerAd.launchUrl.toString(),
              style: StyleManager.bodyStyle,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Delete",
                style: StyleManager.headline,
              ),
            ),
          )
        ],
      ),
    );
  }
}
