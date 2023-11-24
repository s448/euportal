import 'package:eup/Controller/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'Core/Theme/style_manager.dart';

void main(List<String> args) {
  Get.put(HomePageController(), permanent: true);
  return runApp(const EupApp());
}

class EupApp extends StatelessWidget {
  const EupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      theme: StyleManager.themeManager,
      initialRoute: Routes.navbar,
      getPages: getPages,
    );
  }
}
