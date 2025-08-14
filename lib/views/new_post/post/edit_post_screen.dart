// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/create_post_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/create_post_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/edit_post_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/create_post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';

class EditPostScreen extends StatefulWidget {
  final PostModel postModel;
  EditPostScreen({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  State<EditPostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<EditPostScreen> {
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
    return GetBuilder<EditPostController>(
        init: EditPostController(widget.postModel),
        builder: (controller) {
          return Scaffold(
            backgroundColor: darkBackground,
            appBar: AppBar(
              backgroundColor: darkBackground,
              elevation: 1,
              title: Text(
                'Edit Post',
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
              child: SingleChildScrollView(
                physics: MediaQuery.of(context).viewInsets.bottom > 0
                    ? BouncingScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      final totalImagesCount =
                          controller.existingImages.length +
                              controller.pickedImages.length;

                      if (totalImagesCount == 0) return SizedBox.shrink();

                      return SizedBox(
                        height: 230,
                        child: GridView.builder(
                          itemCount: totalImagesCount,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            final isNetworkImage =
                                index < controller.existingImages.length;

                            return Stack(
                              children: [
                                // Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: isNetworkImage
                                      ? Image.network(
                                          controller.existingImages[index],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                      : Image.file(
                                          controller.pickedImages[index -
                                              controller.existingImages.length],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                ),

                                // Delete Icon
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: _publishButton(context),
          );
        });
  }

  Widget _iconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _iconButton(
          Icons.image_outlined,
          'Image',
          () {
            Get.find<EditPostController>().pickImages();
          },
        ),
        _iconButton(
          Icons.person_add_alt_1_outlined,
          'Tag',
          () {},
        ),
        _iconButton(
          Icons.location_on_outlined,
          'Location',
          () {},
        ),
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
      controller: Get.find<EditPostController>().descriptionController,
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
            await Get.find<EditPostController>().editPost(CreatePostModel(
                multipleFiles:
                    Get.find<EditPostController>().pickedImages.value,
                privacy: "public",
                description: Get.find<EditPostController>()
                    .descriptionController
                    .text
                    .trim()));
            Fluttertoast.showToast(msg: "Post uploaded");
            Get.back(result: true);
          } catch (e) {
            Fluttertoast.showToast(msg: "Post $e");
          }
        },
        child: Obx(() => Get.find<EditPostController>().isLoading.value
            ? CircularProgressIndicator.adaptive()
            : Text(
                'Publish Now',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
      ),
    );
  }
}
