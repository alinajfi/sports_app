// shared/post_actions.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';

class PostActions extends StatelessWidget {
  final VoidCallback? onComment;
  final VoidCallback? onRepost;
  final VoidCallback onLike;
  final VoidCallback? onLikesText;
  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final RxBool isLiked;

  const PostActions({
    Key? key,
    this.onComment,
    this.onRepost,
    required this.onLike,
    this.onLikesText,
    this.onShare,
    this.onSave,
    required this.isLiked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.appSize14,
        bottom: AppSize.appSize14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onComment != null)
            _buildActionButton(
              AppIcon.comment,
              AppSize.appSize22,
              AppString.comment10k,
              onComment!,
              onComment,
            ),
          if (onRepost != null)
            _buildActionButton(
              AppIcon.repost,
              AppSize.appSize25,
              AppString.repost15k,
              onRepost!,
              onRepost,
            ),
          Obx(() => _buildActionButton(
                isLiked.value ? AppIcon.like : AppIcon.emptyLike,
                AppSize.appSize26,
                AppString.likes55k,
                onLike,
                onLikesText,
              )),
          if (onShare != null)
            _buildActionButton(
              AppIcon.share,
              AppSize.appSize22,
              AppString.share5k,
              onShare!,
            ),
          _buildActionButton(
            AppIcon.save,
            AppSize.appSize22,
            AppString.save2k,
            onSave ?? () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String icon,
    double width,
    String text,
    VoidCallback onTap, [
    VoidCallback? onTapText,
  ]) {
    final languageController = Get.find<LanguageController>();

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize6,
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize6
                    : AppSize.appSize0,
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Image.asset(icon, width: width),
          ),
        ),
        GestureDetector(
          onTap: onTapText ?? onTap,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: AppSize.appSize14,
              fontWeight: FontWeight.w600,
              fontFamily: AppFont.appFontSemiBold,
              color: AppColor.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

// shared/custom_divider.dart

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColor.lineColor,
      height: AppSize.appSize0,
    );
  }
}
