import 'package:flutter/material.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/dummy_data.dart';

import '../../../config/app_color.dart';
import '../../../config/app_font.dart';
import '../../../config/app_size.dart';
import 'post_actions.dart';

class PostItemDummy extends StatelessWidget {
  const PostItemDummy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.appSize20,
        right: AppSize.appSize20,
        bottom: AppSize.appSize40,
      ),
      child: _withPic(context),
    );
  }

  /// --- Post with Images ---
  Widget _withPic(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(),
        _buildPostImage(context),
        PostActions(
          comomentsCount: dummyPost.commentsCount?.toString() ?? "0",
          onComment: () {},
          onLike: () {},
          isLiked: true,
        ),
        const CustomDivider(),
      ],
    );
  }

  /// --- Post without Images ---
  Widget _withoutPic(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(),
        _buildPostDescription(),
        PostActions(
          comomentsCount: dummyPost.commentsCount?.toString() ?? "0",
          onComment: () {},
          onLike: () {},
          isLiked: false,
        ),
        const CustomDivider(),
      ],
    );
  }

  /// --- Post Header ---
  Widget _buildPostHeader() {
    final isRTL = true;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: isRTL ? 10 : 0,
                    end: isRTL ? 0 : 10,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade400, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        dummyPost.photo!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dummyPost.name!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      Text(
                        dummyPost.location ?? "",
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
                dummyPost.createdAt ?? "",
                style: const TextStyle(
                  fontSize: AppSize.appSize14,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFont.appFontRegular,
                  color: AppColor.text1Color,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// --- Post Image(s) ---
  Widget _buildPostImage(BuildContext context) {
    final images = dummyPost.postImages;

    if (images == null || images.isEmpty) return const SizedBox.shrink();
    final totalImages = images.length;

    // Single image
    if (totalImages == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: AppSize.appSize12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            images[0],
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,
          ),
        ),
      );
    }

    // Multiple images
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
          final mediaUrl = displayImages[index];
          final isLastVisible = index == 3 && totalImages > 4;
          final extraCount = totalImages - 4;

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                mediaUrl,
                fit: BoxFit.cover,
              ),
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
          );
        },
      ),
    );
  }

  /// --- Post Description ---
  Widget _buildPostDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.appSize14),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: AppSize.appSize14,
            fontWeight: FontWeight.w700,
            fontFamily: AppFont.appFontBold,
            color: AppColor.secondaryColor,
          ),
          children: [
            TextSpan(
              text: dummyPost.description ?? "",
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
