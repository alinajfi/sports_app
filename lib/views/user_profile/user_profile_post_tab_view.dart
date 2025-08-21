import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/user_profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/widget_helper.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/home/post_view_dailog.dart';
import '../../../../config/app_size.dart';

class UserProfilePostTabView extends StatelessWidget {
  UserProfilePostTabView({Key? key}) : super(key: key);

  final UserProfileController profileController =
      Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.appSize20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: profileController.postsList.value.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                AppSize.size3, // Use 3 or 4 depending on your design
            crossAxisSpacing: AppSize.appSize8,
            mainAxisSpacing: AppSize.appSize8,
          ),
          itemBuilder: (context, index) {
            final post = profileController.postsList[index];
            final imageUrl =
                post.postImages != null && post.postImages!.isNotEmpty
                    ? post.postImages!.first
                    : null;

            return GestureDetector(
              onTap: () {
                WidgetHelper.showSnackBar();
                if (imageUrl != null) {
                  showDialog(
                    context: context,
                    barrierColor: AppColor.backgroundColor.withOpacity(0.7),
                    builder: (_) => PostViewDialog(
                      isMyProfile: false,
                      imageUrl: imageUrl,
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(AppSize.appSize10),
                ),
                child: imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.appSize10),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(strokeWidth: 1),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
              ),
            );
          },
        ));
  }
}
