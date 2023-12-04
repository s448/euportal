import 'dart:developer';

import 'package:eup/Model/search_item_model.dart';
import 'package:eup/View/Widgets/HomePageWidgets/mosque_item_widget.dart';
import 'package:eup/View/Widgets/HomePageWidgets/portrait_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterResultsView extends StatelessWidget {
  const FilterResultsView({super.key, required this.filterStream});
  final Stream<List<Item>> filterStream;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: StreamBuilder(
        stream: filterStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا يوجد نتائج'));
          } else {
            List<Item> items = snapshot.data!;
            return MosqueListView(items: items);
          }
        },
      ),
    );
  }
}

class PortraitGridView extends StatelessWidget {
  const PortraitGridView({
    super.key,
    required this.items,
  });

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Portrait(
          item: items[index],
        );
      },
    );
  }
}

class MosqueListView extends StatelessWidget {
  const MosqueListView({
    super.key,
    required this.items,
  });

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        log(items.length.toString());
        return MosqueItemWidget(
          item: items[index],
        );
      },
    );
  }
}
