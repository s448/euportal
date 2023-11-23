import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'Core/Theme/style_manager.dart';

void main(List<String> args) {
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
