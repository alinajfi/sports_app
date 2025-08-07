// // ignore_for_file: must_be_immutable

// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';
// import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
// import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
// import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
// import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';
// import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
// import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
// import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
// import 'package:prime_social_media_flutter_ui_kit/model/create_post_model.dart';
// import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
// import 'package:prime_social_media_flutter_ui_kit/controller/new_post/reel_upload_controller.dart';

// import '../../../controller/create_post_controller.dart';

// class CreatePost extends StatelessWidget {
//   CreatePost({Key? key}) : super(key: key);

//   final CreatePostController reelUploadController =
//       Get.put(CreatePostController());
//   final LanguageController languageController = Get.put(LanguageController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: AppColor.backgroundColor,
//       appBar: _appBar(),
//       body: _body(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: _bottomBar(context),
//     );
//   }

//   PreferredSizeWidget _appBar() {
//     return AppBar(
//       backgroundColor: AppColor.backgroundColor,
//       leading: Padding(
//         padding: EdgeInsets.only(
//           left: languageController.selectedLanguageIndex.value == AppSize.size2
//               ? AppSize.appSize0
//               : AppSize.appSize20,
//           right: languageController.selectedLanguageIndex.value == AppSize.size2
//               ? AppSize.appSize20
//               : AppSize.appSize0,
//           top: AppSize.appSize12,
//         ),
//         child: GestureDetector(
//           onTap: () {
//             Get.back();
//             reelUploadController.descriptionController.clear();
//           },
//           child: Image.asset(
//             languageController.selectedLanguageIndex.value == AppSize.size2
//                 ? AppIcon.backRight
//                 : AppIcon.back,
//           ),
//         ),
//       ),
//       leadingWidth: AppSize.appSize44,
//     );
//   }

//   Widget _body() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(
//           horizontal: AppSize.appSize20, vertical: AppSize.appSize24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           DropdownButtonFormField<String>(
//             value: "private",
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: AppColor.cardBackgroundColor,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppSize.appSize12),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//             items: ['public', 'private', 'friends']
//                 .map((privacy) => DropdownMenuItem(
//                       value: privacy,
//                       child: Text(
//                         privacy.capitalize!,
//                         style: TextStyle(color: AppColor.secondaryColor),
//                       ),
//                     ))
//                 .toList(),
//             onChanged: (value) => null ?? 'public',
//           ),
//           const SizedBox(height: AppSize.appSize12),

//           // Description
//           Container(
//             padding: const EdgeInsets.all(AppSize.appSize12),
//             decoration: BoxDecoration(
//               color: AppColor.cardBackgroundColor,
//               borderRadius: BorderRadius.circular(AppSize.appSize12),
//             ),
//             child: TextFormField(
//               controller: reelUploadController.descriptionController,
//               cursorColor: AppColor.secondaryColor,
//               maxLines: AppSize.size5,
//               maxLength: AppSize.size200,
//               style: const TextStyle(
//                 fontSize: AppSize.appSize14,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: AppFont.appFontRegular,
//                 color: AppColor.secondaryColor,
//               ),
//               decoration: const InputDecoration(
//                 contentPadding: EdgeInsets.zero,
//                 hintText: AppString.addDescription,
//                 border: InputBorder.none,
//               ),
//               buildCounter: (context,
//                       {required int currentLength,
//                       required bool isFocused,
//                       int? maxLength}) =>
//                   Text('$currentLength/$maxLength'),
//             ),
//           ),
//           const SizedBox(height: AppSize.appSize12),

//           // Address field
//           TextFormField(
//             controller: TextEditingController(),
//             cursorColor: AppColor.secondaryColor,
//             decoration: InputDecoration(
//               hintText: AppString.addLocation,
//               filled: true,
//               fillColor: AppColor.cardBackgroundColor,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppSize.appSize12),
//                 borderSide: BorderSide.none,
//               ),
//               hintStyle: const TextStyle(
//                 fontSize: AppSize.appSize14,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: AppFont.appFontRegular,
//                 color: AppColor.text1Color,
//               ),
//             ),
//           ),
//           const SizedBox(height: AppSize.appSize12),

//           // Media Picker
//           GestureDetector(
//             onTap: () => reelUploadController.pickMediaFiles(),
//             child: Container(
//               height: AppSize.appSize100,
//               decoration: BoxDecoration(
//                 color: AppColor.cardBackgroundColor,
//                 borderRadius: BorderRadius.circular(AppSize.appSize12),
//               ),
//               child: const Center(
//                 child: Text('Select Media Files'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _bottomBar(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: AppSize.appSize20,
//         right: AppSize.appSize20,
//         bottom: MediaQuery.of(context).viewInsets.bottom + AppSize.appSize32,
//       ),
//       child: GestureDetector(
//         onTap: () async {
//           await reelUploadController.uploadPost(CreatePostModel(
//               privacy: "public",
//               description: reelUploadController.descriptionController.text));
//           Fluttertoast.showToast(msg: "Reel uploaded");
//         },
//         child: Container(
//           height: AppSize.appSize48,
//           decoration: BoxDecoration(
//             color: AppColor.primaryColor,
//             borderRadius: BorderRadius.circular(AppSize.appSize66),
//           ),
//           child: const Center(
//             child: Text(
//               AppString.buttonTextUploadNow,
//               style: TextStyle(
//                 fontSize: AppSize.appSize16,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: AppFont.appFontSemiBold,
//                 color: AppColor.secondaryColor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/create_post_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/create_post_model.dart';

class CreatePost extends StatelessWidget {
  CreatePost({Key? key}) : super(key: key);

  final CreatePostController controller = Get.put(CreatePostController());

  final List<IconData> postIcons = [
    Icons.image_outlined,
    Icons.person_add_alt_1_outlined,
    Icons.emoji_emotions_outlined,
    Icons.location_on_outlined,
    Icons.event_outlined,
  ];

  final List<String> privacyOptions = ['Public', 'Friends', 'Only me'];

  final Color darkBackground = const Color(0xFF121212);
  final Color darkCard = const Color(0xFF1E1E1E);
  final Color primaryText = Colors.white;
  final Color secondaryText = Colors.grey;
  final Color iconColor = Colors.purpleAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
        elevation: 1,
        title: Text(
          'Create Post',
          style: TextStyle(
            color: primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close, color: primaryText),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _userRow(),
            const SizedBox(height: 12),
            _descriptionField(),
            const SizedBox(height: 12),
            Text(
              "Add to your post",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: primaryText,
              ),
            ),
            const SizedBox(height: 8),
            _iconRow(),
            Obx(() {
              if (controller.pickedImages.isEmpty) return SizedBox.shrink();

              return SizedBox(
                height: 230, // ✅ Set your desired height here
                child: GridView.builder(
                  itemCount: controller.pickedImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final imageFile = controller.pickedImages[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _publishButton(context),
    );
  }

  Widget _iconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _iconButton(
          Icons.image_outlined,
          'Image',
          () {
            controller.pickImages();
          },
        ),
        _iconButton(
            Icons.person_add_alt_1_outlined, 'Tag', controller.tagPeople),
        _iconButton(
            Icons.location_on_outlined, 'Location', controller.pickLocation),
      ],
    );
  }

  Widget _iconButton(IconData icon, String tooltip, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: CircleAvatar(
          backgroundColor: const Color(0xFF1E1E1E),
          radius: 22,
          child: Icon(icon, color: Colors.purpleAccent, size: 22),
        ),
      ),
    );
  }

  Widget _userRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Adeel Abbasi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: primaryText,
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: darkCard,
                value: privacyOptions[0],
                icon: Icon(Icons.arrow_drop_down, color: secondaryText),
                items: privacyOptions
                    .map((option) => DropdownMenuItem(
                          value: option,
                          child: Row(
                            children: [
                              Icon(
                                option == 'Public'
                                    ? Icons.public
                                    : option == 'Friends'
                                        ? Icons.group
                                        : Icons.lock,
                                size: 18,
                                color: secondaryText,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                option,
                                style: TextStyle(color: secondaryText),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      controller: controller.descriptionController,
      maxLines: 6,
      style: TextStyle(color: primaryText),
      decoration: InputDecoration(
        hintText: "What's on your mind Adeel Abbasi?",
        hintStyle: TextStyle(
          fontSize: 18,
          color: secondaryText,
        ),
        border: InputBorder.none,
      ),
    );
  }

  Widget _publishButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        ),
        onPressed: () async {
          try {
            await controller.uploadPost(CreatePostModel(
                multipleFiles: controller.pickedImages
                    .map((file) => File(file.path))
                    .toList(),
                privacy: "public",
                description: controller.descriptionController.text));
            Fluttertoast.showToast(msg: "Post uploaded");
            Get.back(result: true);
          } catch (e) {
            Fluttertoast.showToast(msg: "Post $e");
          }
        },
        child: const Text(
          'Publish Now',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
