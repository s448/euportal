import 'package:dashboard/Controller/auth_controller.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controller = Get.put(DashboardAuthController());

  @override
  Widget build(BuildContext context) {
    var emailField = Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          onChanged: (val) {
            controller.email.value = val;
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
    var passwordField = Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          onChanged: (val) {
            controller.password.value = val;
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
            }
            return null;
          },
        ),
      ),
    );
    return Scaffold(
        backgroundColor: ColorManager.primaryC,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                width: Get.width * 0.4,
                child: Obx(() {
                  return Form(
                    key: controller.loginFormKey,
                    child: Column(
                      children: [
                        emailField,
                        const SizedBox(height: 15),
                        passwordField,
                        const SizedBox(height: 25),
                        InkWell(
                          onTap: () => controller.login(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: ColorManager.primaryC,
                            ),
                            child: controller.isLoginLoading.value == true
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Login",
                                    style: StyleManager.authButtonTextStyle),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            )
          ],
        ));
  }
}
