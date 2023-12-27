import 'package:eup/Core/Constant/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Center(
              child: SvgPicture.asset(
                headerSvg,
                width: Get.width * 0.35,
                height: Get.width * 0.35,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
