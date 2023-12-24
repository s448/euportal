import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/View/Screens/NavbarScreens/favorites_page.dart';
import 'package:eup/View/Screens/NavbarScreens/home_page.dart';
import 'package:eup/View/Screens/NavbarScreens/notifications_page.dart';
import 'package:eup/View/Screens/NavbarScreens/profile_page.dart';
import 'package:eup/View/Screens/NavbarScreens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/Theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final homeCtrl = Get.find<HomePageController>();
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);
  @override
  Widget build(BuildContext context) {
    // return Obx(() {
      return PersistentTabView(
        context,
        controller: _controller,
        screens: pages,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: ColorManager.backgroundColor,
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
        true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
        true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),

        navBarStyle: NavBarStyle
            .simple, // Choose the nav bar style with this property.
      );
  }
}

class NavBarItemIcon extends StatelessWidget {
  const NavBarItemIcon({
    super.key,
    required this.imgPath,
    required this.color,
  });
  final String imgPath;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imgPath,
      width: 50,
      height: 50,
      color: color,
    );
  }
}

var pages = <Widget>[
  const ProfilePage(),
  const NotificationsPage(),
  HomePage(),
  const FavoritesPage(),
  SettingsPage(),
];

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      textStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: ColorManager.secondaryC,
      ),
      activeColorSecondary: ColorManager.primaryC,
      inactiveColorSecondary: ColorManager.secondaryC,
      inactiveIcon: const NavBarItemIcon(
        imgPath: profile,
        color: ColorManager.secondaryC,
      ),
      title: ('الملف الشخصي'),
      icon: const NavBarItemIcon(
        imgPath: profile,
        color: ColorManager.primaryC,
      ),
    ),
    PersistentBottomNavBarItem(
      textStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: ColorManager.secondaryC,
      ),
      activeColorSecondary: ColorManager.primaryC,
      inactiveColorSecondary: ColorManager.secondaryC,
      icon: const NavBarItemIcon(
        imgPath: notifications,
        color: ColorManager.primaryC,
      ),
      title: 'الإشعارات',
      inactiveIcon: const NavBarItemIcon(
        imgPath: notifications,
        color: ColorManager.secondaryC,
      ),
    ),
    PersistentBottomNavBarItem(
      textStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: ColorManager.secondaryC,
      ),
      activeColorSecondary: ColorManager.primaryC,
      inactiveColorSecondary: ColorManager.secondaryC,
      icon: const NavBarItemIcon(
        imgPath: home,
        color: ColorManager.primaryC,
      ),
      title: 'الإشعارات',
      inactiveIcon: const NavBarItemIcon(
        imgPath: home,
        color: ColorManager.secondaryC,
      ),
    ),
    PersistentBottomNavBarItem(
      textStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: ColorManager.secondaryC,
      ),
      activeColorSecondary: ColorManager.primaryC,
      inactiveColorSecondary: ColorManager.secondaryC,
      icon: const NavBarItemIcon(
        imgPath: favorites,
        color: ColorManager.primaryC,
      ),
      title: 'المُفضّلة',
      inactiveIcon: const NavBarItemIcon(
        imgPath: favorites,
        color: ColorManager.secondaryC,
      ),
    ),
    PersistentBottomNavBarItem(
      textStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: ColorManager.secondaryC,
      ),
      activeColorSecondary: ColorManager.primaryC,
      inactiveColorSecondary: ColorManager.secondaryC,
      iconSize: 25,
      icon: const NavBarItemIcon(
        imgPath: settings,
        color: ColorManager.primaryC,
      ),
      title: 'الإعدادات',
      inactiveIcon: const NavBarItemIcon(
        imgPath: settings,
        color: ColorManager.secondaryC,
      ),
    ),
  ];
}
