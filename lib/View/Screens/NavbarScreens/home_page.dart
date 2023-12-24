// ignore_for_file: invalid_use_of_protected_member
import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Constant/app_name.dart';
import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/region_model.dart';
import 'package:eup/View/Widgets/HomePageWidgets/filter_results_view.dart';
import 'package:eup/View/Widgets/PreferredWidgets/home_app_bar.dart';
import 'package:eup/View/Widgets/carousel.dart';
import 'package:eup/View/Widgets/HomePageWidgets/restaurant_&_coffee_shop/logo_widget.dart';
import 'package:eup/View/Widgets/HomePageWidgets/restaurant_&_coffee_shop/portrait_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eup/Core/Theme/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final homeCtrl = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(
        child: SizedBox(),
      ),
      body: SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///appbar
              MainAppBar(),
              const SizedBox(height: 10),
              ///header
              const Text(
                "أهلاً بِكَ في $appName...",
                style: TextStyle(
                  color: ColorManager.textC,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ///the banner carousel
              SizedBox(
                width: Get.width,
                child: AppCarousel(
                  homePageController: homeCtrl,
                ),
              ),
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
                                  items: homeCtrl.regions.value
                                      .map((Region region) {
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
              ///drop down button of categories
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
                        items:
                            homeCtrl.categories.value.map((Category category) {
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
              //choose between two states
              /// state 1 => if there's no search or fiter params so view the best choices
              /// state 2 => if the user enters filter params flip to the results view
              Obx(() {
                return homeCtrl.filterMode.value
                    //if no filter params ==> Mode 1 (best of choice)
                    //else ==> view results according to the filter params
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "بناءاً على النتائج الُمدخلة",
                            style: StyleManager.bodyStyle,
                          ),
                          const SizedBox(height: 8),
                          FilterResultsView(controller: homeCtrl),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //best of portrait
                          const Text(
                            "أفضل الإختيارات",
                            style: StyleManager.bodyStyle,
                          ),
                          const SizedBox(height: 8),
                          PortraitStreamBuilder(controller: homeCtrl),
                          const SizedBox(height: 8),
                          //best of logo
                          LogoStreamBuilder(homeCtrl: homeCtrl),
                         const SizedBox(height: 25),
                        ],
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
