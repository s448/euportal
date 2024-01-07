import 'package:dashboard/Controller/regions_controller.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCountryPage extends StatelessWidget {
  AddCountryPage({super.key});
  final controller = Get.find<RegionsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add country",
          style: StyleManager.greenHeadline,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller.countryField,
              onChanged: (val) {
                controller.country.value = val;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                errorStyle: StyleManager.redTip,
                hintText: "Country name",
                hintStyle: StyleManager.hintStyle,
                fillColor: ColorManager.containerBackgroundC,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val!.isEmpty) {
                  return "حقل فارغ";
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: controller.citiesField,
              onChanged: (val) {
                controller.cities.value = val;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                errorStyle: StyleManager.redTip,
                hintText: "Country cities' splitted by ( , )",
                hintStyle: StyleManager.hintStyle,
                fillColor: ColorManager.containerBackgroundC,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val!.isEmpty) {
                  return "حقل فارغ";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () => controller.saveRegion(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.primaryC),
                child: const Text(
                  "Save",
                  style: StyleManager.authButtonTextStyle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
