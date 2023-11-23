import 'package:get/get_navigation/src/routes/get_route.dart';
import 'View/Screens/navbar.dart';

class Routes {
  static String navbar = '/navbar';
}

final getPages = [
  GetPage(
    name: Routes.navbar,
    page: () => const NavBar(),
  ),
];
