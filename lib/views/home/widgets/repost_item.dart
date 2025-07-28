// components/repost_item.dart
import 'package:flutter/foundation.dart';
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

class RepostItem extends StatelessWidget {
  final String imagePath;
  final VoidCallback onLike;
  final RxBool isLiked;
  final String? mainUserName;
  final String? mainUserId;
  final String? mainUserImage;
  final String? mainTimeAgo;
  final String? originalUserName;
  final String? originalUserId;
  final String? originalUserImage;
  final String? originalTimeAgo;
  final String? postDescription;

  const RepostItem({
    Key? key,
    required this.imagePath,
    required this.onLike,
    required this.isLiked,
    this.mainUserName,
    this.mainUserId,
    this.mainUserImage,
    this.mainTimeAgo,
    this.originalUserName,
    this.originalUserId,
    this.originalUserImage,
    this.originalTimeAgo,
    this.postDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final languageController = Get.find<LanguageController>();

    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.appSize10,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
        bottom: AppSize.appSize30,
      ),
      child: Column(
        children: [
          _buildMainUserHeader(languageController),
          _buildRepostCard(languageController),
          PostActions(
            onComment: () {}, // Add comment functionality if needed
            onRepost: () {}, // Add repost functionality if needed
            onLike: onLike,
            onShare: () => homeController.shareAssetImage(imagePath),
            isLiked: isLiked,
          ),
          const CustomDivider(),
          if (postDescription != null) _buildPostDescription(),
        ],
      ),
    );
  }

  Widget _buildMainUserHeader(LanguageController languageController) {
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
              child: Image.asset(
                mainUserImage ?? AppImage.profile4,
                width: AppSize.appSize36,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainUserName ?? AppString.davidMorel,
                  style: const TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.appFontSemiBold,
                    color: AppColor.secondaryColor,
                  ),
                ),
                const Text(
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
              child: Text(
                mainTimeAgo ?? AppString.min33,
                style: const TextStyle(
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

  Widget _buildRepostCard(LanguageController languageController) {
    return Container(
      margin: const EdgeInsets.only(top: AppSize.appSize12),
      padding: const EdgeInsets.all(AppSize.appSize12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.appSize12),
        border: Border.all(color: AppColor.lineColor),
      ),
      child: Column(
        children: [
          _buildOriginalUserHeader(languageController),
          _buildPostImage(),
          _buildOriginalPostDescription(),
        ],
      ),
    );
  }

  Widget _buildOriginalUserHeader(LanguageController languageController) {
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
              child: Image.asset(
                originalUserImage ?? AppImage.profile1,
                width: AppSize.appSize36,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  originalUserName ?? AppString.davidMorel,
                  style: const TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.appFontSemiBold,
                    color: AppColor.secondaryColor,
                  ),
                ),
                const Text(
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
        Text(
          originalTimeAgo ?? AppString.days9,
          style: const TextStyle(
            fontSize: AppSize.appSize14,
            fontWeight: FontWeight.w400,
            fontFamily: AppFont.appFontRegular,
            color: AppColor.text1Color,
          ),
        ),
      ],
    );
  }

  Widget _buildPostImage() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.appSize10),
      child: Image.asset(
        imagePath,
        height: kIsWeb ? AppSize.appSize350 : null,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildOriginalPostDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.appSize12),
      child: RichText(
        text: TextSpan(
          text: originalUserId ?? AppString.davidMorelID,
          style: const TextStyle(
            fontSize: AppSize.appSize12,
            fontWeight: FontWeight.w700,
            fontFamily: AppFont.appFontBold,
            color: AppColor.secondaryColor,
          ),
          children: [
            TextSpan(
              text: postDescription ?? AppString.loremString,
              style: const TextStyle(
                fontSize: AppSize.appSize12,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.appSize12),
      child: RichText(
        text: TextSpan(
          text: mainUserId ?? AppString.davidMorelID,
          style: const TextStyle(
            fontSize: AppSize.appSize14,
            fontWeight: FontWeight.w700,
            fontFamily: AppFont.appFontBold,
            color: AppColor.secondaryColor,
          ),
          children: [
            TextSpan(
              text: postDescription ?? AppString.loremString,
              style: const TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced version with special post header (like the gradient overlay one)
class RepostItemWithOverlay extends StatelessWidget {
  final String imagePath;
  final VoidCallback onLike;
  final RxBool isLiked;
  final String? mainUserName;
  final String? mainUserId;
  final String? referencedUser; // For "Martin Garrix" reference

  const RepostItemWithOverlay({
    Key? key,
    required this.imagePath,
    required this.onLike,
    required this.isLiked,
    this.mainUserName,
    this.mainUserId,
    this.referencedUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final languageController = Get.find<LanguageController>();

    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.appSize48,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
        bottom: AppSize.appSize40,
      ),
      child: Column(
        children: [
          _buildImageWithOverlay(languageController),
          PostActions(
            onComment: () {},
            onRepost: () {},
            onLike: onLike,
            onShare: () => homeController.shareAssetImage(imagePath),
            isLiked: isLiked,
          ),
          const CustomDivider(),
          _buildPostDescription(),
        ],
      ),
    );
  }

  Widget _buildImageWithOverlay(LanguageController languageController) {
    return Stack(
      children: [
        Image.asset(imagePath),
        Container(
          height: AppSize.appSize100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSize.appSize6),
              topRight: Radius.circular(AppSize.appSize6),
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.transparent,
                Colors.black.withAlpha(AppSize.appSizePoint8.toInt()),
              ],
            ),
          ),
        ),
        _buildUserInfoOverlay(languageController),
      ],
    );
  }

  Widget _buildUserInfoOverlay(LanguageController languageController) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.appSize12,
        right: AppSize.appSize12,
        top: AppSize.appSize12,
      ),
      child: Row(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainUserName ?? AppString.rajeshP,
                    style: const TextStyle(
                      fontSize: AppSize.appSize14,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFont.appFontSemiBold,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  if (referencedUser != null)
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize0
                                : AppSize.appSize6,
                          ),
                          child: Image.asset(AppIcon.arrowRightUp,
                              width: AppSize.appSize14),
                        ),
                        Text(
                          referencedUser ?? AppString.martinGarrix,
                          style: const TextStyle(
                            fontSize: AppSize.appSize12,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppFont.appFontRegular,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ],
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
      ),
    );
  }

  Widget _buildPostDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.appSize14),
      child: RichText(
        text: const TextSpan(
          text: AppString.rojModelID,
          style: TextStyle(
            fontSize: AppSize.appSize14,
            fontWeight: FontWeight.w700,
            fontFamily: AppFont.appFontBold,
            color: AppColor.secondaryColor,
          ),
          children: [
            TextSpan(
              text: "${AppString.loremString}\n",
              style: TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
            ),
            WidgetSpan(
              child: Padding(padding: EdgeInsets.only(top: AppSize.appSize22)),
            ),
            TextSpan(
              text: AppString.post3Tags,
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
