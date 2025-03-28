import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SharedSettingsButton extends StatelessWidget {
  const SharedSettingsButton({Key? key, required this.ic, required this.title})
      : super(key: key);
  final String ic;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    ic,
                    width: 15,
                    height: 15,
                    color: ColorManager.secondaryC,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: StyleManager.bodyStyle,
                  )
                ],
              ),
              const Icon(Icons.arrow_forward_ios, size: 15)
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
