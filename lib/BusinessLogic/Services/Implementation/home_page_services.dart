import 'package:eup/BusinessLogic/Services/Interface/i_home_page_services.dart';

class HomePageServices implements IhomePageServices {
  @override
  Future<String> getSearchResult(String q) async {
    return "this is result";
  }
}
