import 'package:auth_buttons/auth_buttons.dart';
import 'package:eup/BusinessLogic/Controller/auth_controller.dart';
import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    var authButtonStyle = const AuthButtonStyle(
      iconSize: 25,
      width: 35,
      height: 35,
      buttonType: AuthButtonType.icon,
      iconType: AuthIconType.secondary,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.12),
            Center(
              child: Image.asset(
                headerIc,
                width: Get.width * 0.35,
                height: Get.width * 0.35,
                // color: ColorManager.primaryC,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "التسجيل",
              style: TextStyle(
                color: ColorManager.primaryC,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "قم بالتسجيل وفتح حساب الآن للتمتع بكامل الخدمات التي يقدمها التطبيق",
              style: StyleManager.info,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),

            ///registration form

            Form(
              key: controller.registerFormKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                hintText: "الإسم الأول",
                                hintStyle: StyleManager.hintStyle,
                                fillColor: ColorManager.containerBackgroundC,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                hintText: "الإسم الثاني",
                                hintStyle: StyleManager.hintStyle,
                                fillColor: ColorManager.containerBackgroundC,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          hintText: "البريد الإلكتروني",
                          hintStyle: StyleManager.hintStyle,
                          fillColor: ColorManager.containerBackgroundC,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          hintText: "كلمة المرور",
                          hintStyle: StyleManager.hintStyle,
                          fillColor: ColorManager.containerBackgroundC,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          hintText: "تأكيد كلمة المرور",
                          hintStyle: StyleManager.hintStyle,
                          fillColor: ColorManager.containerBackgroundC,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Obx(() {
              return Row(
                children: [
                  Checkbox(
                    value: controller.rememberMe.value,
                    onChanged: (v) => controller.flipRememberMe(v),
                  ),
                  const Text(
                    "تذكرني",
                    style: StyleManager.info,
                  )
                ],
              );
            }),
            const SizedBox(height: 4),
            const Center(
              child: Text(
                "التسجيل بواسطة",
                style: StyleManager.info,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleAuthButton(
                  onPressed: () {},
                  style: authButtonStyle,
                ),
                const SizedBox(width: 1),
                TwitterAuthButton(
                  onPressed: () {},
                  style: authButtonStyle,
                ),
                const SizedBox(width: 1),
                FacebookAuthButton(
                  onPressed: () {},
                  style: authButtonStyle,
                ),
              ],
            ),
            const SizedBox(height: 10),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.primaryC),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "الدخول كزائر",
                  style: StyleManager.greenNormalSize,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
