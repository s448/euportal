import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Portrait extends StatelessWidget {
  const Portrait({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.3,
      height: Get.height * 0.25,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: GridTile(
              footer: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مطعم شاورما',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: StyleManager.font,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                            height: 10,
                            child: SvgPicture.asset(
                              locationIc,
                              color: ColorManager.yellowC,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            "2.3 كم",
                            style: TextStyle(
                              fontSize: 8,
                              fontFamily: StyleManager.font,
                              color: ColorManager.yellowC,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "لا يتوفر خدمة توصيل",
                        style: TextStyle(
                          fontSize: 8,
                          fontFamily: StyleManager.font,
                          color: ColorManager.yellowC,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/euportal-bb198.appspot.com/o/portrait%2Fportrait.jpg?alt=media&token=f8c8092d-b8ff-4c57-b2a1-99c99d32ea7d',
                fit: BoxFit.cover,
              ),
              // Add your content here
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              newIc,
              // color: ColorManager.yellowC,
              width: 30,
              height: 30,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              newIc,
              // color: ColorManager.yellowC,
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}
