import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/comments_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/comment_model.dart';
import 'package:prime_social_media_flutter_ui_kit/services/home_services.dart';

LanguageController languageController = Get.put(LanguageController());

commentsBottomSheet(BuildContext context, String postId) {
  CommentsController commentsController =
      Get.put(CommentsController(postId: postId));
  return showModalBottomSheet(
    backgroundColor: AppColor.backgroundColor,
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSize.appSize12),
        topRight: Radius.circular(AppSize.appSize12),
      ),
      borderSide: BorderSide.none,
    ),
    constraints: const BoxConstraints(
      maxWidth: kIsWeb ? AppSize.appSize800 : double.infinity,
    ),
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Container(
          height: AppSize.appSize715,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            top: AppSize.appSize12,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.appSize12),
              topRight: Radius.circular(AppSize.appSize12),
            ),
            color: AppColor.backgroundColor,
          ),
          child: Obx(
            () {
              return commentsController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Column(
                      children: [
                        Container(
                          width: AppSize.appSize28,
                          height: AppSize.appSize2,
                          margin:
                              const EdgeInsets.only(bottom: AppSize.appSize12),
                          decoration: BoxDecoration(
                            color: AppColor.lineColor,
                            borderRadius: BorderRadius.circular(
                              AppSize.appSize6,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSize.appSize16,
                            left: AppSize.appSize20,
                            right: AppSize.appSize20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                AppString.comments,
                                style: TextStyle(
                                  fontSize: AppSize.appSize16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFont.appFontSemiBold,
                                  color: AppColor.secondaryColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  commentsController.commentsFieldController
                                      .clear();
                                },
                                child: Image.asset(
                                  AppIcon.close,
                                  width: AppSize.appSize24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: AppColor.lineColor,
                          height: AppSize.appSize0,
                          endIndent: AppSize.appSize20,
                          indent: AppSize.appSize20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.only(
                              top: AppSize.appSize24,
                              left: AppSize.appSize20,
                              right: AppSize.appSize20,
                            ),
                            child: Column(
                              children: [
                                // Display actual comments from the list
                                ...commentsController.comments
                                    .map(
                                        (comment) => _buildCommentItem(comment))
                                    .toList(),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: AppSize.appSize58,
                          padding: const EdgeInsets.only(
                            left: AppSize.appSize20,
                            right: AppSize.appSize20,
                          ),
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          color: AppColor.cardBackgroundColor,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Image.asset(
                              AppImage.profile4,
                              width: AppSize.appSize32,
                            ),
                            title: TextFormField(
                              cursorColor: AppColor.secondaryColor,
                              controller:
                                  commentsController.commentsFieldController,
                              textInputAction: TextInputAction.newline,
                              style: const TextStyle(
                                fontSize: AppSize.appSize14,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFont.appFontSemiBold,
                                color: AppColor.secondaryColor,
                              ),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(bottom: AppSize.appSize4),
                                hintText: AppString.addComments,
                                hintStyle: TextStyle(
                                  fontSize: AppSize.appSize14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppFont.appFontRegular,
                                  color: AppColor.text2Color,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                commentsController.postComments(postId: postId);
                                commentsController.commentsFieldController
                                    .clear();
                              },
                              child: Image.asset(
                                AppIcon.send,
                                width: AppSize.appSize24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppSize.appSize50,
                        )
                      ],
                    );
            },
          ));
    },
  ).then((result) {
    Get.delete<CommentsController>();
    if (result == null || result == 'dismissed') {
      commentsController.commentsFieldController.clear();
    }
  });
}

Widget _buildCommentItem(Comment comment) {
  return Padding(
    padding: const EdgeInsets.only(bottom: AppSize.appSize16),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize8
                    : AppSize.appSize0,
                right: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize8,
              ),
              child: CircleAvatar(
                radius: AppSize.appSize20,
                backgroundImage: comment.photo.isNotEmpty
                    ? NetworkImage(comment.photo)
                    : const AssetImage(AppImage.comment1) as ImageProvider,
                backgroundColor: AppColor.lineColor,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: languageController
                                          .selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize8
                                  : AppSize.appSize0,
                              right: languageController
                                          .selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize0
                                  : AppSize.appSize8,
                            ),
                            child: Text(
                              comment.name,
                              style: const TextStyle(
                                fontSize: AppSize.appSize14,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFont.appFontSemiBold,
                                color: AppColor.secondaryColor,
                              ),
                            ),
                          ),
                          Text(
                            _formatTime(comment.created),
                            style: const TextStyle(
                              fontSize: AppSize.appSize14,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFont.appFontRegular,
                              color: AppColor.text1Color,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: languageController
                                          .selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize4
                                  : AppSize.appSize0,
                              right: languageController
                                          .selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize0
                                  : AppSize.appSize4,
                            ),
                            child: Image.asset(
                              comment.userReaction != null
                                  ? AppIcon.like
                                  : AppIcon.emptyLike,
                              width: AppSize.appSize18,
                            ),
                          ),
                          Text(
                            _formatLikes(comment.reactionCounts.total ?? 0),
                            style: const TextStyle(
                              fontSize: AppSize.appSize12,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.appFontSemiBold,
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.appSize4),
                    child: Text(
                      comment.description,
                      style: const TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.text2Color,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: AppSize.appSize4),
                    child: Text(
                      AppString.reply,
                      style: TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFont.appFontSemiBold,
                        color: AppColor.text2Color,
                      ),
                    ),
                  ),
                  // Display replies if any
                  if (comment.replies.isNotEmpty)
                    ...comment.replies
                        .map((reply) => _buildReplyItem(reply))
                        .toList(),
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
}

Widget _buildReplyItem(dynamic reply) {
  // Assuming reply has similar structure to comment
  // You may need to adjust this based on your reply model structure
  return Padding(
    padding:
        const EdgeInsets.only(top: AppSize.appSize18, left: AppSize.appSize20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize8
                    : AppSize.appSize0,
            right:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize8,
          ),
          child: CircleAvatar(
            radius: AppSize.appSize14,
            backgroundImage:
                reply['photo'] != null && reply['photo'].toString().isNotEmpty
                    ? NetworkImage(reply['photo'])
                    : const AssetImage(AppImage.comment2) as ImageProvider,
            backgroundColor: AppColor.lineColor,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize8
                                  : AppSize.appSize0,
                          right:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize0
                                  : AppSize.appSize8,
                        ),
                        child: Text(
                          reply['name'] ?? 'Anonymous',
                          style: const TextStyle(
                            fontSize: AppSize.appSize12,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFont.appFontSemiBold,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                      Text(
                        _formatTime(reply['created'] ?? ''),
                        style: const TextStyle(
                          fontSize: AppSize.appSize12,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.text1Color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize4
                                  : AppSize.appSize0,
                          right:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize0
                                  : AppSize.appSize4,
                        ),
                        child: Image.asset(
                          reply['userReaction'] != null
                              ? AppIcon.like
                              : AppIcon.emptyLike,
                          width: AppSize.appSize18,
                        ),
                      ),
                      Text(
                        _formatLikes(
                            reply['reactionCounts']?['totalReactions'] ?? 0),
                        style: const TextStyle(
                          fontSize: AppSize.appSize12,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSize.appSize4),
                child: Text(
                  reply['description'] ?? '',
                  style: const TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.appFontRegular,
                    color: AppColor.text2Color,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: AppSize.appSize4),
                child: Text(
                  AppString.reply,
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.appFontSemiBold,
                    color: AppColor.text2Color,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

String _formatTime(String created) {
  if (created.isEmpty) return '';

  try {
    DateTime createdDate = DateTime.parse(created);
    DateTime now = DateTime.now();
    Duration difference = now.difference(createdDate);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  } catch (e) {
    return created; // Return original string if parsing fails
  }
}

String _formatLikes(int count) {
  if (count >= 1000000) {
    return '${(count / 1000000).toStringAsFixed(1)}M';
  } else if (count >= 1000) {
    return '${(count / 1000).toStringAsFixed(1)}k';
  } else {
    return count.toString();
  }
}
