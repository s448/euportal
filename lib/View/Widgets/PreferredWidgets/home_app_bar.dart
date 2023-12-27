import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/View/Widgets/drawer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Core/Constant/image_path.dart';
import '../../../Core/Theme/colors.dart';
import '../../../Core/Theme/style_manager.dart';

class MainAppBar extends StatelessWidget {
  MainAppBar({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
        title: Text(
          homeCtrl.getAppTitle(),
          style: StyleManager.headline,
        ),
        centerTitle: homeCtrl.isCenterTitle(),
        elevation: 0.0,

        ///if the view index is 0 then it's at [home page]
        ///[home page] can be at 2 states : 1-with filter 2-with best of results
        leading: homeCtrl.getFilterMode() || homeCtrl.viewIndex.value != 0
            ? InkWell(
                ///return back to the index 0 [home page&(state 1)]
                onTap: () {
                  ///we are in home page so
                  ///the back button should back to the best results view mode
                  if (homeCtrl.viewIndex.value == 0) {
                    homeCtrl.resetMode();
                  }

                  ///we are in details page so
                  ///the back button should back to the view index of home page
                  else {
                    Navigator.pop(context);
                    homeCtrl.decrementViewIndex();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 35,
                    color: ColorManager.primaryC,
                  ),
                ),
              )
            : InkWell(
                onTap: () => print(homeCtrl.viewIndex.value),
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  width: Get.width * 0.135,
                  child: SvgPicture.asset(
                    headerSvg,
                    width: 55,
                    height: 55,
                    color: ColorManager.primaryC,
                  ),
                ),
              ),
        actions: [AppDrawer()],
      );
    });
  }
}
