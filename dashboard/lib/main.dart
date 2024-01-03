import 'package:dashboard/View/Screens/home_page.dart';
import 'package:dashboard/firebase_options.dart';
import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  } else {
    await Firebase.initializeApp();
  }
  runApp(const Dashboard());
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController(), permanent: true);
    return GetMaterialApp(
      title: "EU portal Dashboard",
      textDirection: TextDirection.ltr,
      debugShowCheckedModeBanner: false,
      theme: StyleManager.themeManager,
      home: DashboardHomePage(),
      // getPages: getPages,
    );
  }
}
