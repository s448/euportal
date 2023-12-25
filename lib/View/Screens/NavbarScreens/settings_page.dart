import 'package:eup/Core/Constant/app_name.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/View/Widgets/drawer_button.dart';
import 'package:eup/View/Widgets/settings_shared_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Constant/image_path.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const Drawer(
        child: SizedBox(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("الإعدادات"),
        actions: [AppDrawer()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SharedSettingsButton(ic: account, title: "الحساب"),
                div,
                SharedSettingsButton(ic: privacy, title: "سياسة الخصوصية"),
                div,
                SharedSettingsButton(
                    ic: helpCenter, title: "الدعم الفني والمساعدة"),
                div,
                SharedSettingsButton(ic: rateUs, title: "قيمنا"),
                div,
                SharedSettingsButton(ic: whoWeAre, title: "من نحن؟"),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    headerIc,
                    width: 55,
                    height: 55,
                    color: ColorManager.primaryC,
                  ),
                ),
                const Text(
                  "يتم تشغيلة بواسطة فريق $appName",
                  style: StyleManager.smallSizedHint,
                ),
                SizedBox(height: Get.height * 0.08),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const div =
    Divider(color: ColorManager.secondaryC, thickness: 0.15, height: 30);
