// components/text_post_item.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/home_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/post_actions.dart';

class TextPostItem extends StatelessWidget {
  final VoidCallback onLike;
  final RxBool isLiked;

  const TextPostItem({
    Key? key,
    required this.onLike,
    required this.isLiked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final languageController = Get.find<LanguageController>();

    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.appSize20,
        right: AppSize.appSize20,
        bottom: AppSize.appSize40,
      ),
      child: Column(
        children: [
          _buildPostHeader(languageController),
          _buildPostContent(),
          PostActions(
            comomentsCount: "0",
            onLike: onLike,
            onShare: () => homeController.shareAssetImage(AppImage.profile3),
            isLiked: isLiked,
          ),
          const CustomDivider(),
        ],
      ),
    );
  }

  Widget _buildPostHeader(LanguageController languageController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize10,
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize10
                    : AppSize.appSize0,
              ),
              child: Image.asset(AppImage.profile3, width: AppSize.appSize36),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.rajeshP,
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.appFontSemiBold,
                    color: AppColor.secondaryColor,
                  ),
                ),
                Text(
                  AppString.india,
                  style: TextStyle(
                    fontSize: AppSize.appSize12,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.appFontRegular,
                    color: AppColor.text2Color,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: AppSize.appSize8,
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize8
                    : AppSize.appSize0,
              ),
              child: const Text(
                AppString.min2,
                style: TextStyle(
                  fontSize: AppSize.appSize14,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFont.appFontRegular,
                  color: AppColor.text1Color,
                ),
              ),
            ),
            Image.asset(AppIcon.more, width: AppSize.appSize20),
          ],
        ),
      ],
    );
  }

  Widget _buildPostContent() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.appSize12),
      child: RichText(
        text: const TextSpan(
          text: "${AppString.loremString}\n",
          style: TextStyle(
            fontSize: AppSize.appSize14,
            fontWeight: FontWeight.w400,
            fontFamily: AppFont.appFontRegular,
            color: AppColor.secondaryColor,
          ),
          children: [
            WidgetSpan(
              child: Padding(padding: EdgeInsets.only(top: AppSize.appSize28)),
            ),
            TextSpan(
              text: "${AppString.postString}\n",
              style: TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
            ),
            WidgetSpan(
              child: Padding(padding: EdgeInsets.only(top: AppSize.appSize28)),
            ),
            TextSpan(
              text: AppString.postTags,
              style: TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w600,
                fontFamily: AppFont.appFontSemiBold,
                color: AppColor.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
