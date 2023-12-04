import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoGridTile extends StatelessWidget {
  LogoGridTile({super.key, required this.item});
  final Item item;
  final controller = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.viewItemDetails(item),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  item.logo ?? "",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Text(
            item.title ?? "",
            style: const TextStyle(
              color: ColorManager.textC,
              fontFamily: StyleManager.font,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class LogoStreamBuilder extends StatelessWidget {
  const LogoStreamBuilder({
    super.key,
    required this.homeCtrl,
  });

  final HomePageController homeCtrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Get.height * 0.25,
      width: Get.width,
      child: StreamBuilder(
        stream: homeCtrl.logoStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا يوجد نتائج'));
          } else {
            List<Item> items = snapshot.data!;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return LogoGridTile(
                  item: items[index],
                );
              },
            );
          }
        },
      ),
    );
  }
}
