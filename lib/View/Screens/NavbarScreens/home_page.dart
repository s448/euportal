// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/region_model.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:eup/View/Widgets/carousel.dart';
import 'package:eup/View/Widgets/logo_widget.dart';
import 'package:eup/View/Widgets/portrait_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eup/Core/Theme/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final homeCtrl = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "أهلاً بِكَ في بوابة الإتحاد الأوروبي...",
              style: TextStyle(
                color: ColorManager.textC,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(width: Get.width, child: const AppCarousel()),
            const SizedBox(height: 20),

            ///the city and country selection
            Container(
              decoration: StyleManager.dropDownButtonDecoration,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 48.0,
                        width: Get.width * 0.45,
                        child: Obx(() => DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: ColorManager.greyC,
                                ),
                                value: homeCtrl.getCountry().value.isEmpty
                                    ? null
                                    : homeCtrl.getCountry().value,
                                onChanged: (String? newValue) {
                                  homeCtrl.clearCity();
                                  homeCtrl.setCountry(newValue);
                                },
                                style: StyleManager.bodyStyle,
                                items:
                                    homeCtrl.regions.value.map((Region region) {
                                  return DropdownMenuItem<String>(
                                    value: region.country.toString(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(region.country.toString()),
                                    ),
                                  );
                                }).toList(),
                                hint: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: SvgPicture.asset(scope,
                                          color: ColorManager.primaryC),
                                    ),
                                    const SizedBox(width: 3),
                                    const Text(
                                      'الدولة',
                                      style: StyleManager.hintStyle,
                                    ),
                                  ],
                                ),
                                isExpanded: true,
                              ),
                            )),
                      ),
                      const VerticalDivider(
                        color: ColorManager.greyC,
                        thickness: 0.3,
                      ),
                      SizedBox(
                        height: 48,
                        width: Get.width * 0.45,
                        child: Obx(() => DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: ColorManager.greyC,
                                ),
                                value: homeCtrl.getCity().value.isEmpty
                                    ? null
                                    : homeCtrl.getCity().value,
                                onChanged: (String? newValue) {
                                  homeCtrl.setCity(newValue);
                                },
                                style: StyleManager.bodyStyle,
                                items: homeCtrl.selectedRegion.value.cities
                                    ?.map((String? city) {
                                  return DropdownMenuItem<String>(
                                    value: city,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(city.toString()),
                                    ),
                                  );
                                }).toList(),
                                hint: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: SvgPicture.asset(filter,
                                          color: ColorManager.primaryC),
                                    ),
                                    const SizedBox(width: 3),
                                    const Text(
                                      'المدينة',
                                      style: StyleManager.hintStyle,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: StyleManager.dropDownButtonDecoration,
              child: Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      // isDense: true,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: ColorManager.greyC,
                      ),
                      value: homeCtrl.getCategory().value.isEmpty
                          ? null
                          : homeCtrl.getCategory().value,
                      onChanged: (String? newValue) {
                        homeCtrl.setCategory(newValue);
                      },
                      style: StyleManager.bodyStyle,
                      items: homeCtrl.categories.value.map((Category category) {
                        return DropdownMenuItem<String>(
                          value: category.title,
                          child: Text(category.title.toString()),
                        );
                      }).toList(),
                      hint: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              filter,
                              color: ColorManager.primaryC,
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            'قائمة التصنيفات',
                            style: StyleManager.hintStyle,
                          ),
                        ],
                      ),
                      isExpanded: true,
                    ),
                  )),
            ),
            const SizedBox(height: 12),
            const Text(
              "أفضل الإختيارات",
              style: StyleManager.bodyStyle,
            ),
            const SizedBox(height: 8),

            SizedBox(
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
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: Get.height * 0.25,
              width: Get.width,
              child: StreamBuilder(
                stream: homeCtrl.logoStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No data available');
                  } else {
                    List<Item> items = snapshot.data!;
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
            ),
          ],
        ),
      ),
    );
  }
}
