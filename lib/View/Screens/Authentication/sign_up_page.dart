// ignore_for_file: no_leading_underscores_for_local_identifiers

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
    var _emailField = Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          onChanged: (val) {
            controller.setEmail = val;
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            errorStyle: StyleManager.redTip,
            hintText: "البريد الإلكتروني",
            hintStyle: StyleManager.hintStyle,
            fillColor: ColorManager.containerBackgroundC,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (val) {
            if (val!.isEmpty) {
              return "حقل فارغ";
            } else if (!val.isEmail) {
              return "بريد الكتروني غير صالح";
            }
            return null;
          },
        ),
      ),
    );
    var _passwordField = Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          onChanged: (val) {
            controller.setPassword = val;
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            errorStyle: StyleManager.redTip,
            hintText: "كلمة المرور",
            hintStyle: StyleManager.hintStyle,
            fillColor: ColorManager.containerBackgroundC,
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return "حقل فارغ";
            } else if (!controller.isLogin.value &&
                !controller.matchPasswords()) {
              return "كلمتى المرور غير متطابقتين";
            } else if (controller.getPassword.length < 6) {
              return "كلمة المرور ضعيفة";
            }
            return null;
          },
        ),
      ),
    );
    var _confirmPasswordField = Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          onChanged: (val) {
            controller.setConfirmPassword = val;
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            errorStyle: StyleManager.redTip,
            hintText: "تأكيد كلمة المرور",
            hintStyle: StyleManager.hintStyle,
            fillColor: ColorManager.containerBackgroundC,
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return "حقل فارغ";
            } else if (!controller.matchPasswords()) {
              return "كلمتى المرور غير متطابقتين";
            }
            return null;
          },
        ),
      ),
    );
    var _nameFields = Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: TextFormField(
                onChanged: (val) {
                  controller.setFirstName = val;
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  errorStyle: StyleManager.redTip,
                  hintText: "الإسم الأول",
                  hintStyle: StyleManager.hintStyle,
                  fillColor: ColorManager.containerBackgroundC,
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "حقل فارغ";
                  }
                  return null;
                },
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
                onChanged: (val) {
                  controller.setLastName = val;
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  errorStyle: StyleManager.redTip,
                  hintText: "الإسم الثاني",
                  hintStyle: StyleManager.hintStyle,
                  fillColor: ColorManager.containerBackgroundC,
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "حقل فارغ";
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ],
    );
    var _signupForm = Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          _nameFields,
          _emailField,
          _passwordField,
          _confirmPasswordField,
        ],
      ),
    );

    var _loginForm = Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          _emailField,
          _passwordField,
        ],
      ),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
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
              Obx(() {
                return Text(
                  controller.isLogin.value ? "تسجيل الدخول" : "التسجيل",
                  style: const TextStyle(
                    color: ColorManager.primaryC,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
              const SizedBox(height: 12),
              Obx(() {
                return Text(
                  controller.isLogin.value
                      ? "قم بتسجيل الدخول للوصول لكافة الخدمات التي يقدمها التطبيق"
                      : "قم بالتسجيل وفتح حساب الآن للتمتع بكامل الخدمات التي يقدمها التطبيق",
                  style: StyleManager.info,
                  textAlign: TextAlign.center,
                );
              }),
              const SizedBox(height: 25),

              ///registration form
              Obx(() {
                return controller.isLogin.value ? _loginForm : _signupForm;
              }),
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
              Obx(() {
                return InkWell(
                  onTap: () => controller.isLogin.value
                      ? controller.signInWithEmailAndPassword()
                      : controller.createUserWithEmailAndPassword(),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.primaryC),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: controller.signInBtnLoading.value == true
                        ? const CircularProgressIndicator()
                        : const Text(
                            "تسجيل",
                            style: StyleManager.greenNormalSize,
                          ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              Obx(() {
                return Center(
                  child: Text(
                    controller.isLogin.value
                        ? "تسجيل الدخول بواسطة"
                        : "التسجيل بواسطة",
                    style: StyleManager.info,
                  ),
                );
              }),
              const SizedBox(height: 4),

              ///auth with social media
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      authFb,
                      width: Get.width * 0.12,
                      height: Get.height * 0.06,
                    ),
                  ),
                  const SizedBox(width: 7),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      authGoogle,
                      width: Get.width * 0.12,
                      height: Get.height * 0.06,
                    ),
                  ),
                  const SizedBox(width: 7),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      authX,
                      width: Get.width * 0.12,
                      height: Get.height * 0.06,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              ///join as a guest
              InkWell(
                onTap: () =>
                    controller.isLogin.value = !controller.isLogin.value,
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
      ),
    );
  }
}
