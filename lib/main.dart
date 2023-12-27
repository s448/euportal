import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'Core/Theme/style_manager.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      initialRoute: Routes.signup,
      getPages: getPages,
    );
  }
}
