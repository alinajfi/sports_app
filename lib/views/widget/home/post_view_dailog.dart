import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/all_post_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/views/new_post/post/edit_post_screen.dart';

import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_string.dart';

class PostViewDialog extends StatelessWidget {
  final String imageUrl;
  final int? postId;
  final PostModel? post;
  PostViewDialog({required this.imageUrl, super.key, this.postId, this.post});

  AllPostController allPostController = Get.put(AllPostController());

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppSize.appSize20, right: AppSize.appSize20),
        child: Center(
          child: Container(
            width: AppSize.appSize355,
            height: AppSize.appSize273,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(AppSize.appSize12),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: AppSize.appSize218,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppSize.appSize12),
                          topRight: Radius.circular(AppSize.appSize12),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 12,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (post != null) {
                                final result = await Get.to(
                                    () => EditPostScreen(post: post!));
                                if (result == true) {
                                  Get.find<ProfileController>().loadUserPosts();
                                }
                              } else {
                                debugPrint("Post is null, cannot edit.");
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: AppSize.appSize10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              bool isDeleted =
                                  await allPostController.deletePost(
                                postId!,
                              );
                              Get.find<ProfileController>().loadUserPosts();
                              if (isDeleted) {
                                print("✅ Post deleted successfully");
                              } else {
                                print("❌ Failed to delete post");
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.appSize15,
                    left: AppSize.appSize20,
                    right: AppSize.appSize20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _photoOptionWidget(AppIcon.comment, AppSize.appSize22,
                          AppString.comment10k),
                      Obx(() {
                        bool isLiked = allPostController.isLiked.value;
                        return _photoOptionWidget(
                          isLiked ? AppIcon.like : AppIcon.emptyLike,
                          AppSize.appSize24,
                          AppString.likes55k,
                          onTap: () {
                            allPostController.toggleLike();
                          },
                        );
                      }),
                      _photoOptionWidget(
                          AppIcon.share, AppSize.appSize22, AppString.share5k),
                      _photoOptionWidget(
                          AppIcon.save, AppSize.appSize22, AppString.save2k),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_photoOptionWidget(String icon, double width, String text,
    {void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: AppSize.appSize6),
          child: Image.asset(
            icon,
            width: width,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: AppSize.appSize14,
            fontWeight: FontWeight.w600,
            fontFamily: AppFont.appFontSemiBold,
            color: AppColor.secondaryColor,
          ),
        ),
      ],
    ),
  );
}
