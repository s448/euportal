import 'dart:developer';

import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_complex_datatypes/product_model.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:eup/Service/location_service.dart';
import 'package:eup/Service/url_launch_service.dart';
import 'package:eup/View/Widgets/Maps/location_viewer_page.dart';
import 'package:eup/View/Widgets/PreferredWidgets/home_app_bar.dart';
import 'package:eup/View/Widgets/details_info_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

///this page is the body of details page
///it's indexed at 1 position in the shell routes
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.controller, required this.item});
  final HomePageController controller;
  final Item item;
  @override
  Widget build(BuildContext context) {
    final lat = double.parse(item.location?.lat ?? "0.0");
    final long = double.parse(item.location?.long ?? "0.0");

    // final item = controller.viewedItem;
    return Scaffold(
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MainAppBar(),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  ///background image (portrait)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: Get.width,
                      height: 110,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          item?.portrait ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  ///logo image
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 60),
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 38.0,
                          backgroundImage: NetworkImage(
                            item?.logo ?? "",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ///title
              Text(
                item?.title ?? "",
                style: StyleManager.headline,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),

              ///row of info
              ///1-address location
              ///2-rating
              ///3-delivery
              ///4-working hours
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: Get.width,
                  height: Get.height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder(
                          future:
                              LocationService().getLocationAddress(lat, long),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return DetailsWidget(
                                title: "الموقع",
                                value: snapshot.data ?? "غير معروف",
                              );
                            } else if (snapshot.hasError) {
                              log(snapshot.error.toString());
                              return const DetailsWidget(
                                title: "الموقع",
                                value: "غير معروف",
                              );
                            } else {
                              return const Text("");
                            }
                          }),
                      const VerticalDivider(),
                      DetailsWidget(
                        title: "تقييم المكان",
                        isRating: true,
                        value: "4.5",
                      ),
                      const VerticalDivider(),
                      DetailsWidget(
                        title: "خدمة التوصيل",
                        value: item.delivery == true ? "متوفرة" : "غير متوفرة",
                      ),
                      const VerticalDivider(),
                      DetailsWidget(
                        title: "ساعات العمل",
                        value: item?.workingHours ?? "",
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 12),
              Container(
                width: Get.width,
                padding: const EdgeInsets.only(right: 6),
                child: const Text(
                  "المنتجات المتوفرة",
                  style: StyleManager.headline,
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                    childAspectRatio: 1 / 1.3,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: item.products?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    Product? product = item.products?[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(product?.img ??
                                    ""), // Replace with your image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          product?.title ?? "",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "call",
            onPressed: () async {
              try {
                if (await canLaunchUrl(Uri.parse("tel:${item.phone}"))) {
                  await launchUrl(Uri.parse("tel:${item.phone}"));
                } else {
                  throw 'Could not launch';
                }
              } catch (e) {
                log(e.toString());
              }
            },
            shape: const CircleBorder(),
            backgroundColor: ColorManager.blueC,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone_in_talk,
                  size: 35,
                  color: Colors.white,
                ),
                Text("اجراء مكالمة", style: StyleManager.floatingButtonText)
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            heroTag: "directions",
            onPressed: () {
              pushNewScreen(context,
                  withNavBar: true,
                  screen: GoogleMapsPage(latitude: lat, longitude: long));
            },
            shape: const CircleBorder(),
            backgroundColor: ColorManager.blueC,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions,
                  size: 35,
                  color: Colors.white,
                ),
                Text("الاتجاهات", style: StyleManager.floatingButtonText)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
