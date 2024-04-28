import 'package:eup/Core/Constant/app_name.dart';
import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/View/Widgets/PreferredWidgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: CustomScrollView(
          slivers: [
            MainAppBar(),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: Get.height * 0.045),
                    CircleAvatar(
                      radius: Get.width * 0.2,
                    ),
                    const SizedBox(height: 15),
                    const InfoItem(
                      icon: profilePerson,
                      name: "Ahmed Alkilani",
                    ),
                    const SizedBox(height: 6),
                    const InfoItem(
                      icon: profilePassword,
                      name: "eu.gate@gmail.com",
                    ),
                    const SizedBox(height: 6),
                    const InfoItem(
                      icon: profileLocation,
                      name: "Germany",
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(ColorManager.primaryC),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: const Text("تسجيل الخروج"),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              child: const Text("حذف الحساب"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    ColorManager.primaryC),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              child: const Text("تغيير الدولة"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          // onTap: () => controller.signInUsingFacebook(),
                          child: Image.asset(
                            authFb,
                            width: Get.width * 0.08,
                            height: Get.height * 0.06,
                          ),
                        ),
                        const SizedBox(width: 7),
                        InkWell(
                          // onTap: () => controller.signInUsingGoogle(),
                          child: Image.asset(
                            profileInsta,
                            width: Get.width * 0.08,
                            height: Get.height * 0.06,
                          ),
                        ),
                        const SizedBox(width: 7),
                        InkWell(
                          // onTap: () => controller.signInUsingTwitter(),
                          child: Image.asset(
                            authX,
                            width: Get.width * 0.08,
                            height: Get.height * 0.06,
                          ),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                        "تابعنا على مواقع التواصل الاجتماعي",
                        style: StyleManager.greenNormalSize,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 2,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset(
                      headerIc,
                      width: 55,
                      height: 55,
                    ),
                  ),
                  const Text(
                    "يتم تشغيلة بواسطة فريق $appName",
                    style: StyleManager.smallSizedGreenHint,
                  ),
                  SizedBox(height: Get.height * 0.08),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    this.name,
    this.icon,
  });
  final name, icon;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ListTile(
        dense: true,
        tileColor: ColorManager.dropDownButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: ColorManager.greyC,
            fontWeight: FontWeight.w200,
            fontSize: 13,
          ),
        ),
        leading: SizedBox(
          width: 20,
          height: 20,
          child: SvgPicture.asset(
            icon,
            color: ColorManager.greyC,
          ),
        ),
      ),
    );
  }
}
