import 'package:dashboard/View/Screen/tabs/banner_ads_tab.dart';
import 'package:dashboard/View/Screen/tabs/regions/countries_cities.dart';
import 'package:dashboard/View/Screen/tabs/items/products_tab.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBarPage extends StatefulWidget {
  const SideBarPage({super.key});

  @override
  State<SideBarPage> createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage> {
  // final controller = Get.put(UsersController());
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SidebarX(
              controller: _controller,
              showToggleButton: false,
              theme: SidebarXTheme(
                width: Get.width * 0.2,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [ColorManager.primaryC, ColorManager.textC],
                    end: Alignment.topCenter,
                    begin: Alignment.centerLeft,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                // textStyle: TextStyle(color: ColorManager.accentColor),
                selectedTextStyle: const TextStyle(color: Colors.white),
                textStyle: const TextStyle(color: Colors.white),
                itemTextPadding: const EdgeInsets.only(left: 30),
                selectedItemTextPadding: const EdgeInsets.only(left: 30),
                itemDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.only(top: 25),
                selectedItemDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorManager.primaryC),
                ),
                iconTheme: IconThemeData(
                  color: Colors.white.withOpacity(0.7),
                  size: 20,
                ),
                selectedIconTheme: const IconThemeData(
                  color: Colors.white,
                  size: 20,
                ),
              ),
              items: const [
                SidebarXItem(icon: Icons.add_to_queue_outlined, label: 'Items'),
                SidebarXItem(
                  icon: Icons.monitor_heart_sharp,
                  label: 'Banner Ads',
                ),
                SidebarXItem(
                  icon: Icons.notification_add_outlined,
                  label: 'Notifications',
                ),
                SidebarXItem(
                  icon: Icons.edit_location_sharp,
                  label: 'Countries&Cities',
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SideBarBody(
                controller: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SideBarBody extends StatelessWidget {
  const SideBarBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return const SearchItemsTab();
          case 1:
            return BannerAdsTab();
          case 3:
            return CountriesAndCitiesTab();
          default:
            return const SizedBox();
        }
      },
    );
  }
}
