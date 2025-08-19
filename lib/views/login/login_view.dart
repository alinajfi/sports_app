// ignore_for_file: must_be_immutable, deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:prime_social_media_flutter_ui_kit/services/auth_service.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/widget_helper.dart';
import 'package:prime_social_media_flutter_ui_kit/widget/app_button.dart';
import 'package:prime_social_media_flutter_ui_kit/widget/app_textfield.dart';
import '../../config/app_color.dart';
import '../../config/app_font.dart';
import '../../config/app_icon.dart';
import '../../config/app_image.dart';
import '../../config/app_size.dart';
import '../../config/app_string.dart';
import '../../controller/login_controller.dart';
import '../../services/third_party_login_service.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginController = Get.put(LoginController());

  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }

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
                width: 200,
                height: 60,
                fit: BoxFit.fill,
              ),
            ),
            const Text(
              AppString.appDisplayName,
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
            Obx(
              () {
                return loginController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : AppButton(
                        onPressed: () async {
                          if (loginController
                                  .loginField1Controller.text.isEmpty ||
                              loginController.password.value.isEmpty) {
                            loginController.isButtonTapped.value = true;
                          } else {
                            loginController.isLoading.value = true;
                            loginController.isButtonTapped.value = false;
                            final result = await AuthService().loginUser(
                                email: loginController
                                    .loginField1Controller.text
                                    .trim(),
                                password:
                                    loginController.password.value.toString());
                            if (result.$2 != null) {
                              await loginController
                                  .onLoginSuccessFull(result.$2!);
                            } else {
                              await loginController.onLoginFailed(result.$1);
                            }
                          }
                        },
                        text: AppString.buttonTextLogIn,
                        backgroundColor: AppColor.primaryColor,
                        margin: const EdgeInsets.only(top: AppSize.appSize32),
                      );
              },
            ),

            // OR Divider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSize.appSize24),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColor.secondaryColor.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSize.appSize16),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.secondaryColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColor.secondaryColor.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),

            // Social Login Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Google Login Button
                Expanded(
                  child: Container(
                    height: 48,
                    margin: const EdgeInsets.only(right: AppSize.appSize8),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final res =
                              await ThirdPartyLoginService().signInWithGoogle();

                          final data = await ThirdPartyLoginService()
                              .loginWithProvider(
                                  "google", res!.credential!.accessToken!);
                          await Get.find<LoginController>()
                              .onGoogleLoginSuccessfull(
                                  token: data.$2!,
                                  userId: data.$1!.id.toString());
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        elevation: 1,
                        side: BorderSide(
                          color: AppColor.secondaryColor.withOpacity(0.2),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google Icon (You can replace this with your actual Google icon asset)
                          Image.network(
                            'https://developers.google.com/identity/images/g-logo.png',
                            height: 20,
                            width: 20,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.g_mobiledata,
                                color: Colors.red,
                                size: 24,
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Google',
                            style: TextStyle(
                              fontSize: AppSize.appSize14,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFont.appFontRegular,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Facebook Login Button
                Expanded(
                  child: Container(
                    height: 48,
                    margin: const EdgeInsets.only(left: AppSize.appSize8),
                    child: ElevatedButton(
                      onPressed: () async {
                        WidgetHelper.showSnackBar(
                            title: "Comming Soon", description: "");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1877F2),
                        foregroundColor: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Facebook Icon
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.facebook,
                              color: Color(0xFF1877F2),
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Facebook',
                            style: TextStyle(
                              fontSize: AppSize.appSize14,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFont.appFontRegular,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            AppButton(
              onPressed: () {
                Get.toNamed(AppRoutes.signUpView);
              },
              text: AppString.buttonTextSignUp,
              textColor: AppColor.primaryColor,
              side: const BorderSide(color: AppColor.primaryColor),
              margin: const EdgeInsets.only(top: AppSize.appSize24),
            ),
          ],
        ),
      ),
    );
  }
}
