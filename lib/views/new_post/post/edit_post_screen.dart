import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photofilters/photofilters.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:image/image.dart' as imageLib;
import 'package:prime_social_media_flutter_ui_kit/views/new_post/post/filter_photo_screen.dart';


class EditPostScreen extends StatelessWidget {
  final XFile? image;
  const EditPostScreen({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Stack(
          children: [
            image != null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(child: Text(AppString.noImageSelected)),
            Padding(
              padding: const EdgeInsets.only(
                  right: AppSize.appSize20,
                  left: AppSize.appSize20,
                  bottom: AppSize.appSize70,
                  top: AppSize.appSize40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: AppSize.appSize30,
                      width: AppSize.appSize30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSize.appSize3),
                        child: Image.asset(AppIcon.back),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (image != null) {
                            Uint8List bytes = await image!.readAsBytes();

                            imageLib.Image? imageData = imageLib.decodeImage(bytes);

                            if (imageData != null) {
                              imageData = imageLib.copyResize(imageData, width: 600);
                              Map<String, dynamic>? imagefile = await Get.to(() => FilterPhotoScreen(
                                title: const Text("Photo Filter Example"),
                                image: imageData!,
                                filters: presetFiltersList,
                                filename: image!.path.split('/').last,
                                loader: const Center(child: CircularProgressIndicator()),
                                fit: BoxFit.contain,
                              ));

                              if (imagefile != null && imagefile.containsKey('image_filtered')) {
                                imageData = imagefile['image_filtered'];
                              }
                            } else {
                              print("Failed to decode image");
                            }
                          } else {
                            print("No image selected");
                          }
                        },
                        child: Container(
                          height: AppSize.appSize34,
                          decoration: BoxDecoration(
                            color: AppColor.text1Color,
                            borderRadius:
                                BorderRadius.circular(AppSize.appSize66),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.appSize20),
                            child: Center(
                              child: Text(
                                AppString.buttonTextEdit,
                                style: TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontSize: AppSize.appSize14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.reelUploadView);
                        },
                        child: Container(
                          height: AppSize.appSize34,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius:
                                BorderRadius.circular(AppSize.appSize66),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.appSize20),
                            child: Center(
                              child: Text(
                                AppString.buttonTextNext,
                                style: TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontSize: AppSize.appSize14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
