import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:eup/View/Screens/DetailsPage/portrait_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class LogoGridTile extends StatelessWidget {
  LogoGridTile({super.key, required this.item});
  final Item item;
  final controller = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //push the details page as a shell route
        //shell route or child route changes the view of the body without affecting the nav bar or app bar
        pushNewScreen(
          context,
          screen: DetailsPage(controller: controller,item: item),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(controller: controller,item: item)));
        controller.incrementViewStackIndex();
      },
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  item.logo ?? "",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Text(
            item.title ?? "",
            style: const TextStyle(
              color: ColorManager.textC,
              fontFamily: StyleManager.font,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class LogoStreamBuilder extends StatelessWidget {
  const LogoStreamBuilder({
    super.key,
    required this.homeCtrl,
  });

  final HomePageController homeCtrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Get.height * 0.25,
      width: Get.width,
      child: StreamBuilder(
        stream: homeCtrl.logoStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا يوجد نتائج'));
          } else {
            List<Item> items = snapshot.data!;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return LogoGridTile(
                  item: items[index],
                );
              },
            );
          }
        },
      ),
    );
  }
}
