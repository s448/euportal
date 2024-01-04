import 'package:dashboard/Controller/home_controller.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItem extends StatelessWidget {
  AddItem({super.key, required this.itemType});
  final controller = Get.find<HomeController>();
  final Category itemType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Item",
          style: StyleManager.greenHeadline,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Title",
              ),
              onChanged: (v) => controller.item?.title = v,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Description",
              ),
              onChanged: (v) => controller.item?.title = v,
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
