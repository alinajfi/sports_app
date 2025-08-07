// ignore_for_file: public_member_api_docs, sort_constructors_first
// components/post_item.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/home_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/social_media_post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/image_gallery_screen.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/post_actions.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/home/comments_bottom_sheet.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/home/likes_bottom_sheet.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/home/repost_bottom_sheet.dart';

class PostItem extends StatelessWidget {
  final PostModel socialPost;
  final VoidCallback onLike;
  final bool isLiked;
  final dynamic Function(String)? onReactionAdd;
  final dynamic Function(String)? onReactionRemove;
  final HomeController controller;
  final String reactionCount;
  final String commentsCount;

  const PostItem({
    Key? key,
    required this.socialPost,
    required this.onLike,
    required this.isLiked,
    this.onReactionAdd,
    this.onReactionRemove,
    required this.controller,
    required this.reactionCount,
    required this.commentsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final homeController = Get.find<HomeController>();
    //  final languageController = Get.find<LanguageController>();

    return Padding(
        padding: const EdgeInsets.only(
          left: AppSize.appSize20,
          right: AppSize.appSize20,
          bottom: AppSize.appSize40,
        ),
        child: socialPost.postImages == null || socialPost.postImages!.isEmpty
            ? _withPic(context)
            : _withoutpic(context));
  }

  _withPic(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(languageController),
        _buildPostImage(context),
        if (socialPost.postImages == null || socialPost.postImages!.isEmpty)
          _buildPostDescription(),
        GetBuilder<HomeController>(
            id: "actions",
            builder: (cont) {
              return PostActions(
                reactionCount: reactionCount,
                comomentsCount: socialPost.commentsCount?.toString() ?? "",
                onComment: () async {
                  await commentsBottomSheet(
                      context, socialPost.postId.toString());
                },
                onReactionRemove: onReactionRemove,
                onReactionAdd: onReactionAdd,
                onLike: onLike,
                onLikesText: () => likesBottomSheet(context),
                // onShare: () => homeController.shareAssetImage(socialPost.i),
                isLiked: isLiked,
              );
            }),
        const CustomDivider(),
      ],
    );
  }

  _withoutpic(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(languageController),
        _buildPostImage(context),
        if (socialPost.postImages == null || socialPost.postImages!.isEmpty)
          _buildPostDescription(),
        PostActions(
          comomentsCount: socialPost.commentsCount?.toString() ?? "",
          onComment: () async {
            commentsBottomSheet(context, socialPost.postId.toString());
          },
          onReactionRemove: onReactionRemove,
          onReactionAdd: onReactionAdd,
          onLike: onLike,
          onLikesText: () => likesBottomSheet(context),
          // onShare: () => homeController.shareAssetImage(socialPost.i),
          isLiked: isLiked,
        ),
        const CustomDivider(),
      ],
    );
  }

  Widget _buildPostHeader(LanguageController languageController) {
    final isRTL =
        languageController.selectedLanguageIndex.value == AppSize.size2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.userProfile),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: isRTL ? 0 : 10,
                    left: isRTL ? 10 : 0,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      socialPost.photo!,
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        socialPost.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      Text(
                        socialPost.location ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: AppSize.appSize12,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.text2Color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 8,
                left: isRTL ? 8 : 0,
              ),
              child: Text(
                socialPost.createdAt ?? "",
                style: const TextStyle(
                  fontSize: AppSize.appSize14,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFont.appFontRegular,
                  color: AppColor.text1Color,
                ),
              ),
            ),
            Image.asset(
              AppIcon.more,
              width: 20,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPostImage(BuildContext context) {
    final images = socialPost.postImages;

    if (images == null || images.isEmpty) return const SizedBox.shrink();

    final totalImages = images.length;

    // ✅ Single image - take full width
    if (totalImages == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: AppSize.appSize12),
        child: GestureDetector(
          onTap: () => _openImageGallery(context, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              images[0],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
          ),
        ),
      );
    }

    // ✅ More than one image - use grid layout
    final displayImages = totalImages > 4 ? images.take(4).toList() : images;

    return Padding(
      padding: const EdgeInsets.only(top: AppSize.appSize12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: displayImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (gridContext, index) {
          final imageUrl = displayImages[index];
          final isLastVisible = index == 3 && totalImages > 4;
          final extraCount = totalImages - 4;

          return GestureDetector(
            onTap: () => _openImageGallery(context, index),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(imageUrl, fit: BoxFit.cover),
                if (isLastVisible)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        '+$extraCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openImageGallery(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ImageGalleryScreen(
          images: socialPost.postImages!,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  Widget _buildPostDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.appSize14),
      child: RichText(
        text: TextSpan(
          text: socialPost.postId.toString(),
          style: const TextStyle(
            fontSize: AppSize.appSize14,
            fontWeight: FontWeight.w700,
            fontFamily: AppFont.appFontBold,
            color: AppColor.secondaryColor,
          ),
          children: [
            TextSpan(
              text: socialPost.description,
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
