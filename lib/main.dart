import 'dart:developer';

import 'package:eup/BusinessLogic/Controller/user_controller.dart';
import 'package:eup/Core/Constant/app_name.dart';
import 'package:eup/Service/local_storage_service.dart';
import 'package:eup/View/Screens/Authentication/auth_page.dart';
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
  await SharedPreferencesService().init();
  Get.put(UserController(), permanent: true);

  return runApp(EupApp());
}

class EupApp extends StatelessWidget {
  EupApp({super.key});
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    log(userController.isUserAuthenticated().toString());
    return GetMaterialApp(
      title: appName,
      textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      theme: StyleManager.themeManager,
      home: userController.isUserAuthenticated() == false
          ? const NavBar()
          : SignUpPage(),
      getPages: getPages,
    );
  }
}
