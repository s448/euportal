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
import '../../Core/Theme/style_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 2;
  final homeCtrl = Get.find<HomePageController>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            homeCtrl.getCategory().value != ''
                ? "قائمة ال${homeCtrl.getCategory()}"
                : 'بوابة الإتحاد الأوروبي',
            style: StyleManager.headline,
          ),
          centerTitle: homeCtrl.isCenterTitle(),
          elevation: 0.0,
          leading: homeCtrl.viewIndex.value != 0
              ? InkWell(
                  onTap: () => homeCtrl.resetMode(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 35,
                      color: ColorManager.primaryC,
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(6.0),
                  width: Get.width * 0.135,
                  child: Image.asset(
                    headerIc,
                    color: ColorManager.primaryC,
                  ),
                ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(drawerIc),
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            )
          ],
        ),
        endDrawer: const Drawer(
          child: SizedBox(),
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: BorderDirectional(
              top: BorderSide(color: ColorManager.greyC, width: 0.2),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: ColorManager.backgroundColor,
            selectedItemColor: ColorManager.navbarSelected,
            unselectedItemColor: ColorManager.secondaryC,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle:
                const TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
            unselectedLabelStyle:
                const TextStyle(fontSize: 10, fontWeight: FontWeight.w100),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: NavBarItemIcon(
                  imgPath: profile,
                  color: ColorManager.secondaryC,
                ),
                label: 'الملف الشخصي',
                activeIcon: NavBarItemIcon(
                  imgPath: profile,
                  color: ColorManager.primaryC,
                ),
              ),
              BottomNavigationBarItem(
                icon: NavBarItemIcon(
                  imgPath: notifications,
                  color: ColorManager.secondaryC,
                ),
                label: 'الإشعارات',
                activeIcon: NavBarItemIcon(
                  imgPath: notifications,
                  color: ColorManager.primaryC,
                ),
              ),
              BottomNavigationBarItem(
                icon: NavBarItemIcon(
                  imgPath: home,
                  color: ColorManager.secondaryC,
                ),
                label: 'الصفحةالرئيسية',
                activeIcon: NavBarItemIcon(
                  imgPath: home,
                  color: ColorManager.primaryC,
                ),
              ),
              BottomNavigationBarItem(
                icon: NavBarItemIcon(
                  imgPath: favorites,
                  color: ColorManager.secondaryC,
                ),
                label: 'المُفضّلة',
                activeIcon: NavBarItemIcon(
                  imgPath: favorites,
                  color: ColorManager.primaryC,
                ),
              ),
              BottomNavigationBarItem(
                icon: NavBarItemIcon(
                  imgPath: settings,
                  color: ColorManager.secondaryC,
                ),
                label: 'الإعدادات',
                activeIcon: NavBarItemIcon(
                  imgPath: settings,
                  color: ColorManager.primaryC,
                ),
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      );
    });
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
      width: 25,
      height: 25,
      color: color,
    );
  }
}

var pages = <Widget>[
  const ProfilePage(),
  const NotificationsPage(),
  HomePage(),
  const FavoritesPage(),
  const SettingsPage(),
];
