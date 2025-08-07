// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
// import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
// import 'package:prime_social_media_flutter_ui_kit/controller/new_post/create_reel_controller.dart';
// import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
// import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
// import '../../../config/app_color.dart';
// import '../../../config/app_icon.dart';
// import '../../../config/app_image.dart';
// import '../../../config/app_size.dart';

// class CreateReelView extends StatelessWidget {
//   CreateReelView({Key? key}) : super(key: key);

//   LanguageController languageController = Get.put(LanguageController());

//   @override
//   Widget build(BuildContext context) {
//     CreateReelController createReelController = Get.put(CreateReelController());
//     return SafeArea(
//       child: Scaffold(
//         body: _body(context, createReelController),
//       ),
//     );
//   }

//   //Create Reel content
//   _body(BuildContext context, CreateReelController createReelController) {
//     return Column(
//       children: [
//         Expanded(
//           child: Stack(
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 child: Obx(() {
//                   return createReelController.isCameraInitialized.value
//                       ? createReelController.buildCameraPreview()
//                       : Container(color: AppColor.backgroundColor);
//                 }),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: AppSize.appSize20,
//                   top: AppSize.appSize18,
//                   right: AppSize.appSize20,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Image.asset(
//                         languageController.selectedLanguageIndex.value ==
//                                 AppSize.size2
//                             ? AppIcon.backRight
//                             : AppIcon.back,
//                         width: AppSize.appSize24,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Get.toNamed(AppRoutes.reelCaptureView)
//                             ?.whenComplete(() {
//                           createReelController.initializeCamera();
//                         });
//                       },
//                       child: Container(
//                         height: AppSize.appSize34,
//                         width: AppSize.appSize64,
//                         decoration: BoxDecoration(
//                           color: AppColor.primaryColor,
//                           borderRadius:
//                               BorderRadius.circular(AppSize.appSize66),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             AppString.buttonTextNext,
//                             style: TextStyle(
//                               fontSize: AppSize.appSize14,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: AppFont.appFontSemiBold,
//                               color: AppColor.secondaryColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   width: AppSize.appSize34,
//                   height: AppSize.appSize273,
//                   margin: const EdgeInsets.only(right: AppSize.appSize20),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(AppSize.appSize65),
//                     color: AppColor.backgroundColor
//                         .withAlpha(AppSize.appSizePoint5.toInt()),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Image.asset(
//                         AppIcon.music,
//                         width: AppSize.appSize18,
//                       ),
//                       Image.asset(
//                         AppIcon.flip,
//                         width: AppSize.appSize18,
//                       ),
//                       Image.asset(
//                         AppIcon.speed,
//                         width: AppSize.appSize18,
//                       ),
//                       Image.asset(
//                         AppIcon.timer,
//                         width: AppSize.appSize18,
//                       ),
//                       Image.asset(
//                         AppIcon.magic,
//                         width: AppSize.appSize18,
//                       ),
//                       Image.asset(
//                         AppIcon.setting,
//                         width: AppSize.appSize18,
//                       ),
//                       Image.asset(
//                         AppIcon.filter,
//                         width: AppSize.appSize18,
//                       ),
//                       Image.asset(
//                         AppIcon.flash,
//                         width: AppSize.appSize18,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: AppSize.appSize112,
//           padding: const EdgeInsets.only(
//               left: AppSize.appSize20,
//               right: AppSize.appSize20,
//               top: AppSize.appSize24),
//           color: AppColor.backgroundColor,
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       createReelController.openGallery();
//                     },
//                     child: Image.asset(
//                       AppImage.gallery,
//                       width: AppSize.appSize48,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       createReelController.toggleCaptureMode();
//                     },
//                     child: Obx(() => Image.asset(
//                           createReelController.captureMode.value ==
//                                   CaptureMode.video
//                               ? AppImage.videoButton
//                               : AppImage.cameraTouch,
//                           width: AppSize.appSize62,
//                         )),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       createReelController.swapCamera();
//                     },
//                     child: Image.asset(
//                       AppImage.cameraSwap,
//                       width: AppSize.appSize48,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_color.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_image.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';
import '../../../config/app_font.dart';
import '../../../controller/new_post/create_reel_controller.dart';
import '../../../controller/profile/settings_options/language_controller.dart';
import '../../../routes/app_routes.dart';

class CreateReelView extends StatelessWidget {
  CreateReelView({Key? key}) : super(key: key);

  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    final CreateReelController createReelController =
        Get.put(CreateReelController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() {
              return createReelController.isCameraInitialized.value
                  ? createReelController.buildCameraPreview()
                  : Container(color: Colors.black);
            }),

            /// Header with back and Next
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.reelCaptureView)?.whenComplete(() {
                        createReelController.initializeCamera();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        AppString.buttonTextNext,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFont.appFontSemiBold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Right side control panel
            Positioned(
              right: 12,
              top: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  _controlIcon(AppIcon.music),
                  _controlIcon(AppIcon.flip),
                  _controlIcon(AppIcon.speed),
                  _controlIcon(AppIcon.timer),
                  _controlIcon(AppIcon.magic),
                  _controlIcon(AppIcon.setting),
                  _controlIcon(AppIcon.filter),
                  _controlIcon(AppIcon.flash),
                ],
              ),
            ),

            /// Bottom controls
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: createReelController.openGallery,
                    child: Image.asset(AppImage.gallery, width: 40),
                  ),
                  GestureDetector(
                    onTap: createReelController.toggleCaptureMode,
                    child: Obx(() => Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            createReelController.captureMode.value ==
                                    CaptureMode.video
                                ? AppImage.videoButton
                                : AppImage.cameraTouch,
                            width: 52,
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: createReelController.swapCamera,
                    child: Image.asset(AppImage.cameraSwap, width: 40),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable control icon
  Widget _controlIcon(String asset) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Image.asset(asset, width: 20, color: Colors.white),
    );
  }
}
