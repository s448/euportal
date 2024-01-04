import 'package:dashboard/Controller/home_controller.dart';
import 'package:dashboard/View/Screen/tabs/items/item_details.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchItemsTab extends StatelessWidget {
  final controller = Get.put(HomeController());

  SearchItemsTab({super.key});
  @override
  Widget build(BuildContext context) {
    return
        //  Obx(() { return

        LayoutBuilder(builder: (context, BoxConstraints constraints) {
      double screenWidth = constraints.maxWidth;
      int crossAxisCount = (screenWidth / 100).floor();
      return Container(
        color: ColorManager.backgroundColor,
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: controller.portratStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No results"));
                  } else {
                    List<Item> item = snapshot.data!;
                    return Column(
                      children: [
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 1 / 1.4,
                            ),
                            itemCount: item.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: ColorManager.primaryC,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add_business_outlined,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                  ),
                                );
                              } else {
                                return GridItem(item[index - 1]);
                              }
                            },
                          ),
                        )
                      ],
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

class GridItem extends StatelessWidget {
  final Item item;

  const GridItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(const ItemDetails(), arguments: {'item': item}),
      child: AspectRatio(
        aspectRatio: 1 / 1.1,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.logo ?? "",
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                item.title ?? "",
                style: StyleManager.headline,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
