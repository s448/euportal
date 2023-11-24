import 'package:get/get.dart';

class HomePageController extends GetxController {
  RxString country = ''.obs;
  RxString city = ''.obs;
  RxString category = ''.obs;

  List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  void setCountry(String? newValue) {
    country.value = newValue ?? "";
  }

  void setCity(String? newValue) {
    city.value = newValue ?? "";
  }

  void setCategory(String? newValue) {
    category.value = newValue ?? "";
  }
}
