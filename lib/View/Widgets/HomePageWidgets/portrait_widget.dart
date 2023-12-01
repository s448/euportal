import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Portrait extends StatelessWidget {
  const Portrait({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.3,
      height: Get.height * 0.25,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: GridTile(
              footer: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: StyleManager.font,
                          fontSize: 10,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 9,
                            height: 9,
                            child: SvgPicture.asset(
                              locationIc,
                              color: ColorManager.yellowC,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            "2.3 كم",
                            style: TextStyle(
                              fontSize: 6,
                              fontFamily: StyleManager.font,
                              color: ColorManager.yellowC,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        item.delivery == true
                            ? "يتوفر خدمة توصيل"
                            : "لا يتوفر خدمة توصيل",
                        style: const TextStyle(
                          fontSize: 6,
                          fontFamily: StyleManager.font,
                          color: ColorManager.yellowC,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: Image.network(
                item.portrait ?? "",
                fit: BoxFit.cover,
              ),
              // Add your content here
            ),
          ),
          item.isNew == true
              ? Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    newIc,
                    // color: ColorManager.yellowC,
                    width: 25,
                    height: 25,
                  ),
                )
              : const SizedBox(),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              arrowIc,
              // color: ColorManager.yellowC,
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }
}

class PortraitStreamBuilder extends StatelessWidget {
  const PortraitStreamBuilder({
    super.key,
    required this.homeCtrl,
  });

  final HomePageController homeCtrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.25,
      width: Get.width,
      child: StreamBuilder(
        stream: homeCtrl.portratStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No data available');
          } else {
            List<Item> items = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Portrait(
                    item: items[index],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
