// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/sign_up_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/services/auth_service.dart';

import '../../../config/app_color.dart';
import '../../../config/app_font.dart';
import '../../../config/app_image.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';
import '../../../routes/app_routes.dart';
import '../../../widget/app_button.dart';
import '../../../widget/app_textfield.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final signUpController = Get.lazyPut(() => SignUpController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (signUpController) {
      return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: AppSize.appSize48,
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
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            // const Text(
            //   AppString.appDisplayName,
            //   style: TextStyle(
            //     fontSize: AppSize.appSize28,
            //     fontWeight: FontWeight.w400,
            //     fontFamily: AppFont.appFontSevillanaRegular,
            //     color: AppColor.secondaryColor,
            //   ),
            // ),

            const Text(
              AppString.signUpTitle,
              style: TextStyle(
                fontSize: AppSize.appSize28,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontSemiBold,
                color: AppColor.secondaryColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full Name Field
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.appSize52),
                  child: AppTextField(
                    controller: signUpController.fullNameController,
                    labelText: AppString.fullName, // Update string
                    keyboardType: TextInputType.text,
                    cursorColor: AppColor.secondaryColor,
                    fillColor: AppColor.cardBackgroundColor,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      signUpController.fullName.value = value;
                    },
                  ),
                ),
                Obx(() => signUpController.isButtonTap.value &&
                        signUpController.fullName.value.isEmpty
                    ? Text(
                        AppString.nameRequired,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.redColor,
                        ),
                      )
                    : SizedBox.shrink()),

                // Email Field
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.appSize24),
                  child: AppTextField(
                    controller: signUpController.emailController,
                    labelText: AppString.enterEmailAddress,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: AppColor.secondaryColor,
                    fillColor: AppColor.cardBackgroundColor,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      signUpController.email.value = value;
                    },
                  ),
                ),
                Obx(() => signUpController.isButtonTap.value &&
                        signUpController.email.value.isEmpty
                    ? Text(
                        AppString.mobileNoRequired,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.redColor,
                        ),
                      )
                    : SizedBox.shrink()),

                // Password Field
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.appSize24),
                  child: Obx(() => AppTextField(
                        controller: signUpController.passwordController,
                        labelText: AppString.password,
                        keyboardType: TextInputType.text,
                        cursorColor: AppColor.secondaryColor,
                        fillColor: AppColor.cardBackgroundColor,
                        obscureText: signUpController.isPasswordVisible.value,
                        textInputAction: TextInputAction.next,
                        suffixIcon: Padding(
                          padding:
                              const EdgeInsets.only(right: AppSize.appSize16),
                          child: GestureDetector(
                            onTap: () {
                              signUpController.togglePasswordVisibility();
                            },
                            child: Image.asset(
                              signUpController.isPasswordVisible.value
                                  ? AppIcon.eyeClose
                                  : AppIcon.eyeOpen,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          signUpController.password.value = value;
                        },
                        suffixIconColor: AppColor.text2Color,
                        suffixIconConstraints:
                            const BoxConstraints(maxWidth: AppSize.appSize38),
                      )),
                ),
                Obx(() => signUpController.isButtonTap.value &&
                        signUpController.password.value.isEmpty
                    ? Text(
                        AppString.passwordRequired,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.redColor,
                        ),
                      )
                    : SizedBox.shrink()),

                // Confirm Password Field
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.appSize24),
                  child: Obx(() => AppTextField(
                        controller: signUpController.confirmPasswordController,
                        labelText: AppString.confirmPassword,
                        keyboardType: TextInputType.text,
                        cursorColor: AppColor.secondaryColor,
                        fillColor: AppColor.cardBackgroundColor,
                        obscureText:
                            signUpController.isConfirmPasswordVisible.value,
                        textInputAction: TextInputAction.done,
                        suffixIcon: Padding(
                          padding:
                              const EdgeInsets.only(right: AppSize.appSize16),
                          child: GestureDetector(
                            onTap: () {
                              signUpController
                                  .toggleConfirmPasswordVisibility();
                            },
                            child: Image.asset(
                              signUpController.isConfirmPasswordVisible.value
                                  ? AppIcon.eyeClose
                                  : AppIcon.eyeOpen,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          signUpController.confirmPassword.value = value;
                        },
                        suffixIconColor: AppColor.text2Color,
                        suffixIconConstraints:
                            const BoxConstraints(maxWidth: AppSize.appSize38),
                      )),
                ),
                Obx(() {
                  if (!signUpController.isButtonTap.value)
                    return SizedBox.shrink();
                  if (signUpController.confirmPassword.value.isEmpty) {
                    return Text(
                      AppString.confirmPasswordRequired,
                      style: TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.redColor,
                      ),
                    );
                  } else if (signUpController.password.value !=
                      signUpController.confirmPassword.value) {
                    return Text(
                      AppString.confirmPasswordValid,
                      style: TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.redColor,
                      ),
                    );
                  }
                  return SizedBox.shrink();
                }),
              ],
            ),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(top: AppSize.appSize24),
            //       child: AppTextField(
            //         controller: signUpController.addressController,
            //         labelText: AppString.address,
            //         keyboardType: TextInputType.phone,
            //         cursorColor: AppColor.secondaryColor,
            //         fillColor: AppColor.cardBackgroundColor,
            //         inputFormatters: [
            //           LengthLimitingTextInputFormatter(AppSize.size10),
            //         ],
            //         textInputAction: TextInputAction.next,
            //         onChanged: (value) {
            //           signUpController.address.value = value;
            //         },
            //       ),
            //     ),
            //     Obx(() => signUpController.isButtonTap.value &&
            //             signUpController.address.value.isEmpty
            //         ? Text(
            //             AppString.mobileNoRequired,
            //             style: TextStyle(
            //               fontSize: AppSize.appSize14,
            //               fontWeight: FontWeight.w400,
            //               fontFamily: AppFont.appFontRegular,
            //               color: AppColor.redColor,
            //             ),
            //           )
            //         : SizedBox.shrink())
            //   ],
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(top: AppSize.appSize24),
            //       child: AppTextField(
            //         controller: signUpController.postalCodeController,
            //         labelText: AppString.postalCode,
            //         keyboardType: TextInputType.phone,
            //         cursorColor: AppColor.secondaryColor,
            //         fillColor: AppColor.cardBackgroundColor,
            //         inputFormatters: [
            //           LengthLimitingTextInputFormatter(AppSize.size10),
            //         ],
            //         textInputAction: TextInputAction.next,
            //         onChanged: (value) {
            //           signUpController.postalCode.value = value;
            //         },
            //       ),
            //     ),
            //     Obx(() => signUpController.isButtonTap.value &&
            //             signUpController.postalCode.value.isEmpty
            //         ? Text(
            //             AppString.mobileNoRequired,
            //             style: TextStyle(
            //               fontSize: AppSize.appSize14,
            //               fontWeight: FontWeight.w400,
            //               fontFamily: AppFont.appFontRegular,
            //               color: AppColor.redColor,
            //             ),
            //           )
            //         : SizedBox.shrink())
            //   ],
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(top: AppSize.appSize24),
            //       child: Obx(() => AppTextField(
            //             controller: signUpController.confirmPasswordController,
            //             labelText: AppString.confirmPassword,
            //             keyboardType: TextInputType.text,
            //             cursorColor: AppColor.secondaryColor,
            //             fillColor: AppColor.cardBackgroundColor,
            //             obscureText:
            //                 signUpController.isConfirmPasswordVisible.value,
            //             textInputAction: TextInputAction.done,
            //             onChanged: (value) {
            //               signUpController.confirmPass.value = value;
            //             },
            //             suffixIcon: Padding(
            //               padding:
            //                   const EdgeInsets.only(right: AppSize.appSize16),
            //               child: GestureDetector(
            //                 onTap: () {
            //                   signUpController.toggleConfirmPasswordVisibility();
            //                 },
            //                 child: Image.asset(
            //                   signUpController.isConfirmPasswordVisible.value
            //                       ? AppIcon.eyeClose
            //                       : AppIcon.eyeOpen,
            //                 ),
            //               ),
            //             ),
            //             suffixIconColor: AppColor.text2Color,
            //             suffixIconConstraints: const BoxConstraints(
            //               maxWidth: AppSize.appSize38,
            //             ),
            //           )),
            //     ),
            //     Obx(() => signUpController.isButtonTap.value &&
            //             signUpController.confirmPass.value.isEmpty
            //         ? Text(
            //             AppString.confirmPasswordRequired,
            //             style: TextStyle(
            //               fontSize: AppSize.appSize14,
            //               fontWeight: FontWeight.w400,
            //               fontFamily: AppFont.appFontRegular,
            //               color: AppColor.redColor,
            //             ),
            //           )
            //         : signUpController.confirmPass.value !=
            //                 signUpController.password.value
            //             ? Text(
            //                 AppString.confirmPasswordValid,
            //                 style: TextStyle(
            //                   fontSize: AppSize.appSize14,
            //                   fontWeight: FontWeight.w400,
            //                   fontFamily: AppFont.appFontRegular,
            //                   color: AppColor.redColor,
            //                 ),
            //               )
            //             : SizedBox.shrink())
            //   ],
            // ),
            GetX<SignUpController>(
              builder: (cont) {
                return AppButton(
                  onPressed: () async {
                    cont.isButtonTap.value = true;

                    // Validate fields
                    bool isFormInvalid = cont.fullName.value.isEmpty ||
                        cont.email.value.isEmpty ||
                        cont.password.value.isEmpty ||
                        cont.confirmPassword.value.isEmpty ||
                        cont.password.value != cont.confirmPassword.value;

                    cont.isDateInvalid.value = cont.selectedDate.value == null;

                    if (isFormInvalid) {
                      cont.isShowingUsername.value = true;
                      return;
                    }

                    cont.isloading.value = true;
                    cont.isButtonTap.value = false;
                    cont.isDateInvalid.value = false;

                    try {
                      final result = await AuthService().registerUser(
                        email: cont.emailController.text.trim(),
                        password: cont.passwordController.text.trim(),
                      );

                      cont.isloading.value = false;

                      if (result.$2) {
                        Get.toNamed(AppRoutes.welcomeView);
                      } else {
                        log(result.$1);
                        Fluttertoast.showToast(msg: result.$1);
                      }
                    } catch (e) {
                      log("$e");
                      cont.isloading.value = false;
                      Fluttertoast.showToast(msg: e.toString());
                    }
                  },
                  text: cont.isloading.value
                      ? AppString.pleaseWait
                      : AppString.buttonTextSignUp,
                  backgroundColor: AppColor.primaryColor,
                  margin: const EdgeInsets.only(top: AppSize.appSize32),
                );
              },
            ),

            // AppButton(
            //   onPressed: () {
            //     Get.toNamed(AppRoutes.loginView);
            //   },
            //   text: AppString.buttonTextLogIn,
            //   textColor: AppColor.primaryColor,
            //   side: const BorderSide(color: AppColor.primaryColor),
            //   margin: const EdgeInsets.only(top: AppSize.appSize12),
            // ),

            SizedBox(
              height: AppSize.appSize24,
            ),

            // AppButton(
            //     text: 'Continue',
            //     backgroundColor: AppColor.primaryColor,
            //     margin: const EdgeInsets.only(top: AppSize.appSize32),
            //     onPressed: () async {
            //       signUpController.pageController.jumpToPage(1);
            //     }),

            // SizedBox(
            //   height: AppSize.appSize34,
            // ),

            const Text(
              AppString.signUpWithSocial,
              style: TextStyle(
                fontSize: AppSize.appSize15,
                fontWeight: FontWeight.w200,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
            ),
            SizedBox(
              height: AppSize.appSize34,
            ),
          ],
        ),
      );
    });
  }
}
