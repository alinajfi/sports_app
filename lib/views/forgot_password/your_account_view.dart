// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/forgot_password/your_account_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';

import '../../config/app_color.dart';
import '../../config/app_font.dart';
import '../../config/app_string.dart';
import '../../widget/app_button.dart';
import '../../widget/app_textfield.dart';

class YourAccountView extends StatelessWidget {
  YourAccountView({Key? key}) : super(key: key);

  YourAccountController yourAccountController =
      Get.put(YourAccountController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: AppSize.appSize20),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppIcon.back),
        ),
      ),
      leadingWidth: AppSize.appSize44,
    );
  }

  _body() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: AppSize.appSize24),
            child: Text(
              AppString.letsFindYourAccount,
              style: TextStyle(
                fontSize: AppSize.appSize24,
                fontWeight: FontWeight.w700,
                fontFamily: AppFont.appFontBold,
                color: AppColor.secondaryColor,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: AppSize.appSize8),
            child: Text(
              AppString.letsFindYourAccountString,
              style: TextStyle(
                fontSize: AppSize.appSize16,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.text2Color,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: AppSize.appSize24),
                child: AppTextField(
                  controller: yourAccountController.emailFieldController,
                  labelText: AppString.loginField1,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: AppColor.secondaryColor,
                  fillColor: AppColor.cardBackgroundColor,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    yourAccountController.email.value = value;
                  },
                ),
              ),
              Obx(() => yourAccountController.isButtonTap.value && yourAccountController.email.value.isEmpty
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
          AppButton(
            onPressed: () {
              if (yourAccountController.email.value.isEmpty) {
                yourAccountController.isButtonTap.value = true;
              } else {
                yourAccountController.isButtonTap.value = false;
                Get.toNamed(AppRoutes.codeConfirmationView);
              }
            },
            text: AppString.buttonTextNext,
            backgroundColor: AppColor.primaryColor,
            margin: const EdgeInsets.only(top: AppSize.appSize32),
          ),
        ],
      ),
    );
  }
}
