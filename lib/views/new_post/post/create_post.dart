// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/create_post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/new_post/reel_upload_controller.dart';

import '../../../controller/create_post_controller.dart';

class CreatePost extends StatelessWidget {
  CreatePost({Key? key}) : super(key: key);

  final CreatePostController reelUploadController =
      Get.put(CreatePostController());
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: _body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _bottomBar(context),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(
          left: languageController.selectedLanguageIndex.value == AppSize.size2
              ? AppSize.appSize0
              : AppSize.appSize20,
          right: languageController.selectedLanguageIndex.value == AppSize.size2
              ? AppSize.appSize20
              : AppSize.appSize0,
          top: AppSize.appSize12,
        ),
        child: GestureDetector(
          onTap: () {
            Get.back();
            reelUploadController.descriptionController.clear();
          },
          child: Image.asset(
            languageController.selectedLanguageIndex.value == AppSize.size2
                ? AppIcon.backRight
                : AppIcon.back,
          ),
        ),
      ),
      leadingWidth: AppSize.appSize44,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSize.appSize20, vertical: AppSize.appSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: "private",
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.cardBackgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.appSize12),
                borderSide: BorderSide.none,
              ),
            ),
            items: ['public', 'private', 'friends']
                .map((privacy) => DropdownMenuItem(
                      value: privacy,
                      child: Text(
                        privacy.capitalize!,
                        style: TextStyle(color: AppColor.secondaryColor),
                      ),
                    ))
                .toList(),
            onChanged: (value) => null ?? 'public',
          ),
          const SizedBox(height: AppSize.appSize12),

          // Description
          Container(
            padding: const EdgeInsets.all(AppSize.appSize12),
            decoration: BoxDecoration(
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(AppSize.appSize12),
            ),
            child: TextFormField(
              controller: reelUploadController.descriptionController,
              cursorColor: AppColor.secondaryColor,
              maxLines: AppSize.size5,
              maxLength: AppSize.size200,
              style: const TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: AppString.addDescription,
                border: InputBorder.none,
              ),
              buildCounter: (context,
                      {required int currentLength,
                      required bool isFocused,
                      int? maxLength}) =>
                  Text('$currentLength/$maxLength'),
            ),
          ),
          const SizedBox(height: AppSize.appSize12),

          // Address field
          TextFormField(
            controller: TextEditingController(),
            cursorColor: AppColor.secondaryColor,
            decoration: InputDecoration(
              hintText: AppString.addLocation,
              filled: true,
              fillColor: AppColor.cardBackgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.appSize12),
                borderSide: BorderSide.none,
              ),
              hintStyle: const TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.text1Color,
              ),
            ),
          ),
          const SizedBox(height: AppSize.appSize12),

          // Media Picker
          GestureDetector(
            onTap: () => reelUploadController.pickMediaFiles(),
            child: GetX<CreatePostController>(
              init: CreatePostController(),
              builder: (cont) {
                return Container(
                  height: AppSize.appSize100,
                  decoration: BoxDecoration(
                    color: AppColor.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(AppSize.appSize12),
                  ),
                  child: Center(
                    child: cont.pickedFiles.isEmpty
                        ? Text(
                            'Select Media Files',
                            style: TextStyle(color: Colors.white),
                          )
                        : Wrap(
                            children: cont.pickedFiles
                                .where((file) =>
                                    file.path != null) // Filter out null paths
                                .map((file) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.file(
                                        File(
                                            file.path!), // Convert path to File
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                                .toList(),
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSize.appSize20,
        right: AppSize.appSize20,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSize.appSize32,
      ),
      child: GestureDetector(
        onTap: () async {
          await reelUploadController.uploadPost(CreatePostModel(
              multipleFiles: reelUploadController.pickedFiles
                  .map((pf) => File(pf.path!))
                  .toList(),
              privacy: "public",
              description: reelUploadController.descriptionController.text));
          Fluttertoast.showToast(msg: "Reel uploaded");
        },
        child: GetX<CreatePostController>(
          builder: (cont) {
            return Container(
              height: AppSize.appSize48,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(AppSize.appSize66),
              ),
              child: Center(
                child: cont.isLoading.value
                    ? CircularProgressIndicator.adaptive()
                    : Text(
                        AppString.buttonTextUploadNow,
                        style: TextStyle(
                          fontSize: AppSize.appSize16,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.secondaryColor,
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
