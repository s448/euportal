import 'package:dashboard/Controller/home_controller.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:eup/View/Widgets/HomePageWidgets/restaurant_&_coffee_shop/portrait_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardHomePage extends StatelessWidget {
  DashboardHomePage({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Home"),
        ),
        body: SizedBox(
          height: Get.height * 0.25,
          width: Get.width,
          child: StreamBuilder(
            stream: controller.portratStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('لا يوجد نتائج'));
              } else {
                List<Item> items = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Portrait(
                        item: items[index],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
