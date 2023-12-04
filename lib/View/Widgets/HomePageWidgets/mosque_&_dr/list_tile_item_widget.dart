import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ListTileItemWidget extends StatelessWidget {
  const ListTileItemWidget({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        height: Get.height * 0.29,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.primaryC),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.27,
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      item.portrait ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title ?? "",
                        style: StyleManager.greenHeadline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      //mosque info
                      item.category?.title == "مساجد"
                          ? Wrap(
                              direction: Axis.horizontal,
                              children: [
                                MosqueInfoWidget(
                                  imgPath: wodoaIc,
                                  text: item.mosqueAblutionFacilities == true
                                      ? "يتوفر مرافق للوضوء"
                                      : "لا يتوفر مرافق للوضوء",
                                ),
                                MosqueInfoWidget(
                                  imgPath: womenPrayerIc,
                                  text: item.womenPrayerRoom == true
                                      ? "يتوفر مكان خاص للنساء"
                                      : "لا يتوفر مكان خاص للنساء",
                                ),
                                MosqueInfoWidget(
                                  imgPath: prayerIc,
                                  text: item.allPrayers == true
                                      ? "جميع الصلوات وصلاة الجمعة"
                                      : "جميع الصلوات عدا صلاة الجمعة",
                                ),
                                MosqueInfoWidget(
                                  imgPath: lessonIc,
                                  text: item.lessonAfterEshaa == true
                                      ? "درس بعد صلاة العشاء"
                                      : "لا يتوفر درس بعد صلاة العشاء",
                                ),
                              ],
                            )
                          : const SizedBox(),
                      Text(
                        item.description ?? "",
                        style: StyleManager.details,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Divider(
                        endIndent: Get.width * 0.2,
                      ),
                      item.category?.title == "مساجد"
                          ? Text(
                              item.mosqueCapacity ?? "",
                              style: StyleManager.info,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      callIc,
                                      color: ColorManager.textC,
                                      width: 15,
                                      height: 15,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        "0045464545",
                                        style: StyleManager.info,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      fbIc,
                                      color: ColorManager.textC,
                                      width: 15,
                                      height: 15,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    SvgPicture.asset(
                                      instaIc,
                                      color: ColorManager.textC,
                                      width: 15,
                                      height: 15,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        item.title ?? "",
                                        style: StyleManager.info,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                      //location
                      Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "المسافة بينك و بين ${item.title} 3 كم",
                                    style: StyleManager.info,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    item.location?.lat ?? "",
                                    style: StyleManager.info,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                arrowIc,
                // color: ColorManager.yellowC,
                width: 25,
                height: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MosqueInfoWidget extends StatelessWidget {
  const MosqueInfoWidget({
    super.key,
    required this.imgPath,
    required this.text,
  });
  final String imgPath;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.3,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                imgPath,
                color: Colors.red,
                width: 15,
                height: 15,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  text,
                  style: StyleManager.redTip,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
