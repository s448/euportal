import 'dart:developer';

import 'package:dashboard/Controller/home_controller.dart';
import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/region_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_region_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key, required this.itemType});
  final Category itemType;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  void initState() {
    super.initState();
    controller.item.value.category = widget.itemType;
  }

  final controller = Get.find<HomeController>();
  final homeCtrl = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اضافة ${widget.itemType.title}",
          style: StyleManager.greenHeadline,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                ///select country and city

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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
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
                                    items: homeCtrl.regions.value
                                        .map((Region region) {
                                      return DropdownMenuItem<String>(
                                        value: region.country.toString(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child:
                                              Text(region.country.toString()),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: ColorManager.greyC,
                                    ),
                                    value: homeCtrl.getCity().value.isEmpty
                                        ? null
                                        : homeCtrl.getCity().value,
                                    onChanged: (String? newValue) {
                                      homeCtrl.setCity(newValue);
                                      print(homeCtrl.getCity().value);
                                      controller.item.value.region = ItemRegion(
                                        city: homeCtrl.getCity().value,
                                        country: homeCtrl.getCountry().value,
                                      );
                                      print(controller.item.value.region?.city);
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

                const SizedBox(height: 30),

                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      hintText: "Title",
                    ),
                    onChanged: (v) => controller.item.value.title = v,
                    initialValue: controller.item.value.title,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      hintText: "Description",
                    ),
                    onChanged: (v) => controller.item.value.description = v,
                    maxLines: 4,
                    initialValue: controller.item.value.description,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      hintText: "Working hours",
                    ),
                    onChanged: (v) => controller.item.value.workingHours = v,
                    initialValue: controller.item.value.workingHours,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      hintText: "Facebook",
                    ),
                    onChanged: (v) => controller.item.value.fb = v,
                    initialValue: controller.item.value.fb,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      hintText: "Instagram",
                    ),
                    onChanged: (v) => controller.item.value.insta = v,
                    initialValue: controller.item.value.insta,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Checkbox(
                      value: controller.item.value.delivery ?? false,
                      onChanged: (v) {
                        setState(() {
                          controller.item.value.delivery = v;
                        });
                      },
                    ),
                    const Text(
                      "Delivery availible",
                      style: StyleManager.headline,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: controller.item.value.mosqueAblutionFacilities ??
                          false,
                      onChanged: (v) {
                        setState(() {
                          controller.item.value.mosqueAblutionFacilities = v;
                        });
                      },
                    ),
                    const Text(
                      "متاح مرافق للوضوء",
                      style: StyleManager.headline,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: controller.item.value.allPrayers ?? false,
                      onChanged: (v) {
                        setState(() {
                          controller.item.value.allPrayers = v;
                        });
                      },
                    ),
                    const Text(
                      "جميع الصلاوات وصلاة الجمعة",
                      style: StyleManager.headline,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: controller.item.value.lessonAfterEshaa ?? false,
                      onChanged: (v) {
                        setState(() {
                          controller.item.value.lessonAfterEshaa = v;
                        });
                      },
                    ),
                    const Text(
                      "متاح درس بعد صلاة العشاء",
                      style: StyleManager.headline,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: controller.item.value.womenPrayerRoom ?? false,
                      onChanged: (v) {
                        setState(() {
                          controller.item.value.womenPrayerRoom = v;
                        });
                      },
                    ),
                    const Text(
                      "متاح مصلى للنساء",
                      style: StyleManager.headline,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: controller.item.value.featuredPortrait ?? false,
                      onChanged: (v) {
                        setState(() {
                          controller.item.value.featuredPortrait = v;
                        });
                      },
                    ),
                    const Text(
                      "Featured portrait",
                      style: StyleManager.headline,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: controller.item.value.featuredLogo ?? false,
                      onChanged: (v) {
                        setState(() {
                          controller.item.value.featuredLogo = v;
                        });
                      },
                    ),
                    const Text(
                      "Featured logo",
                      style: StyleManager.headline,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: InkWell(
        onTap: () => controller.saveItem(),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: ColorManager.primaryC,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                "Upload changes",
                style: StyleManager.authButtonTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
