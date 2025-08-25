// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/all_post_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/widget_helper.dart';
import 'package:prime_social_media_flutter_ui_kit/views/new_post/post/edit_post_screen.dart';

import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_string.dart';

class PostViewDialog extends StatelessWidget {
  final String imageUrl;
  final int? postId;
  final PostModel? post;
  final bool isMyProfile;
  PostViewDialog({
    Key? key,
    required this.imageUrl,
    this.postId,
    this.post,
    required this.isMyProfile,
  }) : super(key: key);

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
                      child: isMyProfile
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (post != null) {
                                      await Get.to(() => EditPostScreen(
                                            isFromVideo: false,
                                            postModel: post!,
                                          ));
                                      Get.find<ProfileController>()
                                          .loadUserPosts();
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
                                    Navigator.of(context).pop();
                                    bool isDeleted =
                                        await allPostController.deletePost(
                                      post!.postId!,
                                    );
                                    Get.find<ProfileController>()
                                        .loadUserPosts();
                                    if (isDeleted) {
                                      WidgetHelper.showSnackBar(
                                          title: "✅ Post deleted successfully");
                                    } else {
                                      WidgetHelper.showSnackBar(
                                          title: "Failed to delete");
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
                            )
                          : SizedBox(),
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

class VideoViewDialog extends StatefulWidget {
  final String videoUrl; // 👈 Only video URL
  final PostModel? post;
  final bool isMyProfile;

  const VideoViewDialog({
    Key? key,
    required this.videoUrl,
    this.post,
    required this.isMyProfile,
  }) : super(key: key);

  @override
  State<VideoViewDialog> createState() => _VideoViewDialogState();
}

class _VideoViewDialogState extends State<VideoViewDialog> {
  final AllPostController allPostController = Get.put(AllPostController());
  Uint8List? _thumbnail;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: widget.videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 400, // constrain thumbnail size
      quality: 75,
    );
    if (mounted) {
      setState(() {
        _thumbnail = uint8list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.appSize20),
        child: Center(
          child: Container(
            width: AppSize.appSize355,
            height: AppSize.appSize273,
            decoration: BoxDecoration(
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(AppSize.appSize12),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    // 📌 Thumbnail or placeholder
                    Container(
                      height: AppSize.appSize218,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppSize.appSize12),
                          topRight: Radius.circular(AppSize.appSize12),
                        ),
                        color: Colors.black12,
                      ),
                      child: _thumbnail != null
                          ? ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(AppSize.appSize12),
                                topRight: Radius.circular(AppSize.appSize12),
                              ),
                              child: Image.memory(
                                _thumbnail!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                    // 📌 Play button overlay
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    // 📌 Edit/Delete
                    Positioned(
                      top: 8,
                      right: 12,
                      child: widget.isMyProfile
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (widget.post != null) {
                                      await Get.to(() => EditPostScreen(
                                            isFromVideo: true,
                                            postModel: widget.post!,
                                          ));
                                      Get.find<ProfileController>()
                                          .loadUserPosts();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
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
                                const SizedBox(width: AppSize.appSize10),
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    bool isDeleted =
                                        await allPostController.deletePost(
                                      widget.post!.postId!,
                                    );
                                    Get.find<ProfileController>()
                                        .loadUserPosts();
                                    if (isDeleted) {
                                      WidgetHelper.showSnackBar(
                                          title:
                                              "✅ Video deleted successfully");
                                    } else {
                                      WidgetHelper.showSnackBar(
                                          title: "Failed to delete");
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
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
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
                // 📌 Bottom row (like/share/save)
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.appSize15,
                    left: AppSize.appSize20,
                    right: AppSize.appSize20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _optionWidget(AppIcon.comment, AppSize.appSize22,
                          AppString.comment10k),
                      Obx(() {
                        bool isLiked = allPostController.isLiked.value;
                        return _optionWidget(
                          isLiked ? AppIcon.like : AppIcon.emptyLike,
                          AppSize.appSize24,
                          AppString.likes55k,
                          onTap: () {
                            allPostController.toggleLike();
                          },
                        );
                      }),
                      _optionWidget(
                          AppIcon.share, AppSize.appSize22, AppString.share5k),
                      _optionWidget(
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

  Widget _optionWidget(String icon, double width, String text,
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
}
