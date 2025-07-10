// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/profile/options/logout_bottom_sheet.dart';
import '../../../config/app_color.dart';
import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_size.dart';
import '../../../controller/profile/settings_options/language_controller.dart';
import '../../../routes/app_routes.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: _body(context),
    );
  }

  _appBar() {
    LanguageController languageController = Get.put(LanguageController());
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      scrolledUnderElevation: AppSize.appSize0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: AppSize.appSize12, left: AppSize.appSize6),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: AppSize.appSize12,
                left: languageController.selectedLanguageIndex.value == AppSize.size2 ? AppSize.appSize13 : AppSize.appSize0,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  languageController.selectedLanguageIndex.value == AppSize.size2 ? AppIcon.backRight : AppIcon.back,
                  width: AppSize.appSize24,
                ),
              ),
            ),
            Text(
              AppString.settingsT.tr,
              style: const TextStyle(
                fontSize: AppSize.appSize20,
                fontWeight: FontWeight.w600,
                fontFamily: AppFont.appFontSemiBold,
                color: AppColor.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _body(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
          top: AppSize.appSize24,
          left: AppSize.appSize20,
          right: AppSize.appSize20,
          bottom: AppSize.appSize10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.accountView);
            },
            child: Container(
              padding: const EdgeInsets.only(
                left: AppSize.appSize12,
                top: AppSize.appSize14,
                right: AppSize.appSize14,
                bottom: AppSize.appSize14,
              ),
              margin: const EdgeInsets.only(bottom: AppSize.appSize16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.appSize12),
                color: AppColor.cardBackgroundColor,
              ),
              child: _customSettingsOptions(
                text: AppString.accountT.tr,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.notificationsOptionView);
            },
            child: Container(
              padding: const EdgeInsets.only(
                left: AppSize.appSize12,
                top: AppSize.appSize14,
                right: AppSize.appSize14,
                bottom: AppSize.appSize14,
              ),
              margin: const EdgeInsets.only(bottom: AppSize.appSize16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.appSize12),
                color: AppColor.cardBackgroundColor,
              ),
              child: _customSettingsOptions(
                text: AppString.notificationsT.tr,
              ),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.blockView);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: AppSize.appSize12,
                    top: AppSize.appSize14,
                    right: AppSize.appSize14,
                    bottom: AppSize.appSize14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(AppSize.appSize12), topRight: Radius.circular(AppSize.appSize12)),
                    color: AppColor.cardBackgroundColor,
                  ),
                  child: _customSettingsOptions(
                    text: AppString.blockT.tr,
                  ),
                ),
              ),
              _reusableDivider(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.hideStoryView);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: AppSize.appSize12,
                    top: AppSize.appSize14,
                    right: AppSize.appSize14,
                    bottom: AppSize.appSize14,
                  ),
                  margin: const EdgeInsets.only(bottom: AppSize.appSize16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(AppSize.appSize12), bottomRight: Radius.circular(AppSize.appSize12)),
                    color: AppColor.cardBackgroundColor,
                  ),
                  child:  _customSettingsOptions(
                    text: AppString.hideStoryT.tr,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.likeView);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: AppSize.appSize12,
                    top: AppSize.appSize14,
                    right: AppSize.appSize14,
                    bottom: AppSize.appSize14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.cardBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      _customSettingsOptions(
                        text: AppString.likeT.tr,
                      ),
                      ],),),),
              _reusableDivider(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.commentView);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: AppSize.appSize12,
                    top: AppSize.appSize14,
                    right: AppSize.appSize14,
                    bottom: AppSize.appSize14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.cardBackgroundColor,
                  ),
                  child:   _customSettingsOptions(
                    text: AppString.commentsT.tr,
                  ),
                ),
              ),
              _reusableDivider(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.repostOptionView);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: AppSize.appSize12,
                    top: AppSize.appSize14,
                    right: AppSize.appSize14,
                    bottom: AppSize.appSize14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.cardBackgroundColor,
                  ),
                  child:   _customSettingsOptions(
                    text: AppString.repostT.tr,
                  ),
                ),
              ),
              _reusableDivider(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.hiddenWordsView);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: AppSize.appSize12,
                    top: AppSize.appSize14,
                    right: AppSize.appSize14,
                    bottom: AppSize.appSize14,
                  ),
                  margin: const EdgeInsets.only(bottom: AppSize.appSize16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(AppSize.appSize12),bottomLeft: Radius.circular(AppSize.appSize12)),
                    color: AppColor.cardBackgroundColor,
                  ),
                  child:   _customSettingsOptions(
                    text: AppString.hiddenWordsT.tr,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.languageView);
            },
            child: Container(
              padding: const EdgeInsets.only(
                left: AppSize.appSize12,
                top: AppSize.appSize14,
                right: AppSize.appSize14,
                bottom: AppSize.appSize14,
              ),
              margin: const EdgeInsets.only(bottom: AppSize.appSize16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.appSize12),
                color: AppColor.cardBackgroundColor,
              ),
              child: _customSettingsOptions(
                text: AppString.languageT.tr,
              ),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.helpView);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: AppSize.appSize12,
                    top: AppSize.appSize14,
                    right: AppSize.appSize14,
                    bottom: AppSize.appSize14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(AppSize.appSize12),topRight: Radius.circular(AppSize.appSize12)),
                    color: AppColor.cardBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      _customSettingsOptions(
                        text: AppString.helpT.tr,
                      ),

                    ],
                  ),
                ),
              ),
              _reusableDivider(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.aboutView);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: AppSize.appSize12,
                    top: AppSize.appSize14,
                    right: AppSize.appSize14,
                    bottom: AppSize.appSize14,
                  ),
                  margin: const EdgeInsets.only(bottom: AppSize.appSize16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(AppSize.appSize12),bottomRight: Radius.circular(AppSize.appSize12)),
                    color: AppColor.cardBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      _customSettingsOptions(
                        text: AppString.aboutT.tr,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(
                top: AppSize.appSize4, bottom: AppSize.appSize10),
            child: GestureDetector(
              onTap: () {
                logoutBottomSheet(context);
              },
              child: Text(
                AppString.logoutT.tr,
                style: const TextStyle(
                  fontSize: AppSize.appSize16,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFont.appFontRegular,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ),
          Text(
            AppString.logoutAllAccountsT.tr,
            style: const TextStyle(
              fontSize: AppSize.appSize16,
              fontWeight: FontWeight.w400,
              fontFamily: AppFont.appFontRegular,
              color: AppColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  _customSettingsOptions({required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppSize.appSize2),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: AppSize.appSize14,
              fontWeight: FontWeight.w400,
              fontFamily: AppFont.appFontRegular,
              color: AppColor.secondaryColor,
            ),
          ),
        ),
        Image.asset(
          AppIcon.rightArrow,
          width: AppSize.appSize20,
        ),
      ],
    );
  }

  _reusableDivider() {
    return Divider(
      height: AppSize.appSize0,
      color: AppColor.borderColor,
    );
  }
}
