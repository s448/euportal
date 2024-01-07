import 'package:dashboard/Controller/home_controller.dart';
import 'package:dashboard/View/Screen/tabs/items/add_item.dart';
import 'package:dashboard/View/Screen/tabs/items/item_details.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchItemsTab extends StatefulWidget {
  const SearchItemsTab({super.key});

  @override
  State<SearchItemsTab> createState() => _SearchItemsTabState();
}

class _SearchItemsTabState extends State<SearchItemsTab> {
  final controller = Get.put(HomeController());

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
                                return InkWell(
                                  onTap: () => showCategories(context),
                                  child: Container(
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

  Future<dynamic> showCategories(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Select Item type'),
              content: SizedBox(
                width: Get.width * 0.4,
                height: Get.height * 0.2,
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1.5,
                  ),
                  shrinkWrap: true,
                  children: List.generate(controller.categories?.length ?? 0,
                      (index) {
                    Category cat = controller.categories![index];
                    return InkWell(
                      onTap: () => Get.to(AddItem(
                        itemType: cat,
                      )),
                      child: Container(
                        width: Get.width * 0.3,
                        height: Get.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            cat.title ?? "",
                            style: StyleManager.greenHeadline,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ));
  }
}

class GridItem extends StatelessWidget {
  final Item item;

  const GridItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(ItemDetails(), arguments: {'item': item}),
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
