import 'package:eup/View/Screens/Authentication/sign_up_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'View/Screens/navbar.dart';

class Routes {
  static String navbar = '/navbar';
  static String login = '/login';
  static String signup = '/signup';
}

final getPages = [
  GetPage(
    name: Routes.navbar,
    page: () => const NavBar(),
  ),
  GetPage(
    name: Routes.signup,
    page: () => const SignUpPage(),
  ),
];
