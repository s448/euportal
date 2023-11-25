import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/View/Widgets/carousel.dart';
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
            InkWell(
              onTap: () => print(homeCtrl.getSearchResults("q")),
              child: const Text(
                "أهلاً بِكَ في بوابة الإتحاد الأوروبي...",
                style: TextStyle(
                  color: ColorManager.textC,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(width: Get.width, child: const AppCarousel()),
            const SizedBox(height: 20),
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
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: ColorManager.greyC,
                                ),
                                value: homeCtrl.getCountry().value.isEmpty
                                    ? null
                                    : homeCtrl.getCountry().value,
                                onChanged: (String? newValue) {
                                  homeCtrl.setCountry(newValue);
                                },
                                style: StyleManager.bodyStyle,
                                items: homeCtrl.options.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(option),
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
                                items: homeCtrl.options.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(option),
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
                      items: homeCtrl.options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
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
          ],
        ),
      ),
    );
  }
}
