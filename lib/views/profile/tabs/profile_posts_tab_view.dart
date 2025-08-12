// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
// import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
// import 'package:prime_social_media_flutter_ui_kit/views/widget/home/post_view_dailog.dart';
// import '../../../../config/app_size.dart';

// class ProfilePostsTabView extends StatelessWidget {
//   ProfilePostsTabView({Key? key}) : super(key: key);

//   ProfileController profileController = Get.put(ProfileController());

//   @override
//   Widget build(BuildContext context) {
//     return _profilePostsTab();
//   }

//   _profilePostsTab() {
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: AppSize.appSize20,
//         right: AppSize.appSize20,
//       ),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: AlwaysScrollableScrollPhysics(),
//         // physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: AppSize.size4,
//           crossAxisSpacing: AppSize.appSize1,
//           mainAxisSpacing: AppSize.appSize1,
//         ),
//         itemCount: profileController.postsList.length,
//         itemBuilder: (BuildContext context, index) {
//           return GestureDetector(
//             onTap: () {
//               // showDialog(
//               //   context: context,
//               //   barrierColor: AppColor.backgroundColor
//               //       .withAlpha(AppSize.appSizePoint7.toInt()),
//               //   builder: (context) {
//               //     return PostViewDialog(
//               //         imageUrl: profileController.postsList[index]);
//               //   },
//               // );
//             },
//             child: Container(
//               child: profileController
//                       .postsList.value[index].postImages!.isNotEmpty
//                   ? Image.network(profileController
//                       .postsList.value[index].postImages!.first)
//                   : SizedBox(),
//               decoration: BoxDecoration(

//                   // image: DecorationImage(
//                   //   image: profileController
//                   //           .postsList[index].postImages!.isNotEmpty
//                   //       ? NetworkImage(
//                   //           profileController.postsList[index].postImages!.first)
//                   //       : Image.asset(),
//                   //   fit: BoxFit.cover,
//                   // ),
//                   ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/home/post_view_dailog.dart';
import '../../../../config/app_size.dart';
// import '../post_view_dialog_my_profile.dart';

class ProfilePostsTabView extends StatelessWidget {
  ProfilePostsTabView({Key? key}) : super(key: key);

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.appSize20),
      child: Obx(
        () => GridView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: profileController.postsList.length,
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
                if (imageUrl != null) {
                  showDialog(
                    context: context,
                    barrierColor: AppColor.backgroundColor.withOpacity(0.7),
                    builder: (_) => PostViewDialog(
                      post: post,
                      imageUrl: post.photo!,
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
        ),
      ),
    );
  }
}
