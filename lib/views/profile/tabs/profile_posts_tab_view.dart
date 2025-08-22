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
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/views/new_post/post/create_post.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/home/post_view_dailog.dart';
import '../../../../config/app_size.dart';
import 'package:video_player/video_player.dart';
// import '../post_view_dialog_my_profile.dart';
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

            //log(imageUrl.toString());

            if (_isVideo(imageUrl!))
              return UrlPreview(
                url: imageUrl,
              );

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: AppColor.backgroundColor.withOpacity(0.7),
                  builder: (_) => PostViewDialog(
                    isMyProfile: true,
                    post: post,
                    imageUrl: post.postImages!.first,
                  ),
                );
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
                    : SizedBox.shrink(),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _isVideo(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;

    final extension = uri.path.toLowerCase().split('.').last;
    return ['mp4', 'mov', 'avi', 'mkv', 'webm', 'm4v'].contains(extension);
  }
}

class UrlPreview extends StatefulWidget {
  final String url;
  const UrlPreview({Key? key, required this.url}) : super(key: key);

  @override
  State<UrlPreview> createState() => _UrlPreviewState();
}

class _UrlPreviewState extends State<UrlPreview> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();

    final ext = widget.url.split('.').last.toLowerCase();
    if (ext == "mp4" || ext == "mov" || ext == "avi" || ext == "mkv") {
      _videoController = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          setState(() {}); // refresh after init
          _videoController?.play(); // auto play (optional)
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ext = widget.url.split('.').last.toLowerCase();

    return SizedBox(
      height: 230,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ext == "jpg" || ext == "jpeg" || ext == "png"
            ? Image.network(
                widget.url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Center(child: Icon(Icons.error, color: Colors.red)),
              )
            : (_videoController != null &&
                    _videoController!.value.isInitialized)
                ? AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: VideoPlayer(_videoController!),
                  )
                : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
