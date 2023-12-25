import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Core/Theme/style_manager.dart';
import 'package:rate/rate.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget(
      {Key? key, required this.title, required this.value, this.isRating})
      : super(key: key);
  final String title;
  final String value;
  final bool? isRating;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StyleManager.infoTitle,
          ),
          const SizedBox(height: 6),
          isRating == true
              ? Column(
                  children: [
                    const Text("4.5",
                        style: TextStyle(color: Colors.yellow, fontSize: 6)),
                    Rate(
                      iconSize: 12,
                      color: Colors.yellow,
                      allowHalf: true,
                      allowClear: true,
                      initialValue: 3.5,
                      readOnly: false,
                      onChange: (value) => print(value),
                    ),
                  ],
                )
              : Text(
                  value,
                  style: StyleManager.infoValue,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                )
        ],
      ),
    );
  }
}
