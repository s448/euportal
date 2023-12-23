import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:eup/View/Widgets/PreferedWidgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///this page is the body of details page
///it's indexed at 1 position in the shell routes
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.controller, required this.item});
  final HomePageController controller;
  final Item item;
  @override
  Widget build(BuildContext context) {
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
              Text(
                item?.title ?? "",
                style: StyleManager.headline,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: Get.width,
                  height: Get.height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "الموقع",
                          ),
                          Text(
                            item?.location?.lat ?? "غير محدد",
                            style: StyleManager.hintStyle,
                          )
                        ],
                      ),
                      const VerticalDivider(),
                      Column(
                        children: [
                          const Text(
                            "خدمة التوصيل",
                            style: TextStyle(),
                          ),
                          Text(
                            item?.delivery == true ? "متوفرة" : "غير متوفرة",
                            style: StyleManager.hintStyle,
                          )
                        ],
                      ),
                      const VerticalDivider(),
                      Column(
                        children: [
                          const Text(
                            "ساعات العمل",
                          ),
                          Text(
                            item?.workingHours ?? "",
                            style: StyleManager.hintStyle,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
