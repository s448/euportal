import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoGridTile extends StatelessWidget {
  const LogoGridTile({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
