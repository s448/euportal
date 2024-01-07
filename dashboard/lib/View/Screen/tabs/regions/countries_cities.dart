import 'package:dashboard/Controller/regions_controller.dart';
import 'package:dashboard/View/Screen/tabs/regions/add_region.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/region_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountriesAndCitiesTab extends StatelessWidget {
  CountriesAndCitiesTab({super.key});
  final controller = Get.put(RegionsController());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
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
                stream: controller.getRegions,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No results"));
                  } else {
                    List<Region> item = snapshot.data!;
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
                                  onTap: () => Get.to(AddCountryPage()),
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
                                return RegionItem(item: item[index - 1]);
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

class RegionItem extends StatelessWidget {
  RegionItem({super.key, required this.item});
  final controller = Get.find<RegionsController>();
  final Region item;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.primaryC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: AspectRatio(
            aspectRatio: 1 / 1.4,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item.country ?? "",
                    style: StyleManager.infoTitle,
                  ),
                  ListView.builder(
                    itemCount: item.cities?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Text(
                      item.cities?[index] ?? "",
                      style: StyleManager.infoValue,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            child: IconButton(
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirm delete this country"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              controller.deleteRegion(item.id ?? "");
                              Get.back();
                            },
                            child: const Text(
                              "Delete",
                              style: StyleManager.redTip,
                            ),
                          )
                        ],
                      ),
                    ),
                icon: const Icon(
                  CupertinoIcons.delete,
                  color: Colors.red,
                  size: 18,
                ))),
      ],
    );
  }
}
