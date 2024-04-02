import 'dart:typed_data';

import 'package:dashboard/Controller/ad_banners_controller.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBannerPage extends StatelessWidget {
  AddBannerPage({super.key});
  final controller = Get.find<AdBannersController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Banner",
          style: StyleManager.greenHeadline,
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () => controller.pickBannerImg(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: controller.bannerImg.value.isNotEmpty
                      ? Column(
                          children: [
                            Image.memory(
                              controller.bannerImg.value,
                              width: 60,
                              height: 60,
                            ),
                            IconButton(
                                onPressed: () =>
                                    controller.bannerImg.value = Uint8List(0),
                                icon: const Icon(
                                  CupertinoIcons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        )
                      : const Column(
                          children: [
                            Icon(Icons.image),
                            Text(
                              "Pick logo",
                              style: StyleManager.greenHeadline,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: controller.launchUrlField,
                onChanged: (val) {
                  controller.launchUrl.value = val;
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
                  hintText: "Launch url",
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
              InkWell(
                onTap: () => controller.saveBanner(),
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
        );
      }),
    );
  }
}
