// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:prime_social_media_flutter_ui_kit/services/auth_service.dart';
import 'package:prime_social_media_flutter_ui_kit/widget/app_button.dart';
import 'package:prime_social_media_flutter_ui_kit/widget/app_textfield.dart';
import '../../config/app_color.dart';
import '../../config/app_font.dart';
import '../../config/app_icon.dart';
import '../../config/app_image.dart';
import '../../config/app_size.dart';
import '../../config/app_string.dart';
import '../../controller/login_controller.dart';
import '../signup/pages/parent_details_page.dart';
import '../signup/pages/social_details_page.dart';
import '../signup/pages/sports_selection_page.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _body(),
      ),
    );
  }

  //Login content
  _body() {
    return Center(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(
          left: AppSize.appSize20,
          right: AppSize.appSize20,
          bottom: AppSize.appSize12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppSize.appSize24),
              child: Image.asset(
                AppImage.appLogo,
                width: AppSize.appSize66,
              ),
            ),
            const Text(
              AppString.primeSocialMedia,
              style: TextStyle(
                fontSize: AppSize.appSize28,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontSevillanaRegular,
                color: AppColor.secondaryColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.appSize109),
                  child: AppTextField(
                    controller: loginController.loginField1Controller,
                    labelText: AppString.loginField1,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: AppColor.secondaryColor,
                    fillColor: AppColor.cardBackgroundColor,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      loginController.email.value = text;
                      loginController.update();
                    },
                    suffixIcon: Obx(
                      () => loginController.isButtonTapped.value &&
                              loginController.email.value.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: AppSize.appSize16),
                              child: Image.asset(AppIcon.error),
                            )
                          : const SizedBox.shrink(),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      maxWidth: AppSize.appSize38,
                    ),
                  ),
                ),
                Obx(() => loginController.isButtonTapped.value &&
                        loginController.loginField1Controller.text.isEmpty
                    ? Text(
                        AppString.emailRequired,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.redColor,
                        ),
                      )
                    : SizedBox.shrink())
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.appSize24),
                  child: AppTextField(
                    controller: loginController.loginField2Controller,
                    labelText: AppString.loginField2,
                    keyboardType: TextInputType.text,
                    cursorColor: AppColor.secondaryColor,
                    fillColor: AppColor.cardBackgroundColor,
                    onChanged: (value) {
                      loginController.password.value = value;
                      loginController.update();
                    },
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Obx(() => (loginController.isButtonTapped.value &&
                        loginController.password.value.isEmpty)
                    ? Text(
                        AppString.passwordRequired,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.redColor,
                        ),
                      )
                    : SizedBox.shrink())
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSize.appSize12),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.yourAccountView);
                  },
                  child: const Text(
                    AppString.forgotPassword,
                    style: TextStyle(
                      fontSize: AppSize.appSize14,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.appFontRegular,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ),
              ),
            ),
            AppButton(
              onPressed: () async {
                if (loginController.loginField1Controller.text.isEmpty ||
                    loginController.password.value.isEmpty) {
                  loginController.isButtonTapped.value = true;
                } else {
                  loginController.isButtonTapped.value = false;
                  Get.toNamed(AppRoutes.welcomeView);
                }
              },
              text: AppString.buttonTextLogIn,
              backgroundColor: AppColor.primaryColor,
              margin: const EdgeInsets.only(top: AppSize.appSize32),
            ),
            AppButton(
              onPressed: () {
                Get.toNamed(AppRoutes.signUpView);
              },
              text: AppString.buttonTextSignUp,
              textColor: AppColor.primaryColor,
              side: const BorderSide(color: AppColor.primaryColor),
              margin: const EdgeInsets.only(top: AppSize.appSize12),
            ),
          ],
        ),
      ),
    );
  }
}
