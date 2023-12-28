import 'dart:developer';

import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Constant/app_name.dart';
import 'package:eup/Service/local_storage_service.dart';
import 'package:eup/View/Screens/Authentication/sign_up_page.dart';
import 'package:eup/View/Screens/navbar.dart';
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
  await SharedPreferencesService().init();

  return runApp(EupApp());
}

class EupApp extends StatelessWidget {
  EupApp({super.key});
  final _sharedPrefs = SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    log(_sharedPrefs.isUserLoggedInAndRemembered().toString());
    return GetMaterialApp(
      title: appName,
      textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      theme: StyleManager.themeManager,
      home: _sharedPrefs.isUserLoggedInAndRemembered() == true
          ? const NavBar()
          : SignUpPage(),
      getPages: getPages,
    );
  }
}
