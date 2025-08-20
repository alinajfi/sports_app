import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/model/create_post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/create_story_model.dart';
import '../../controller/auth_controller.dart';
import '../../controller/create_story_controller.dart';

class CreateStory extends StatefulWidget {
  const CreateStory({Key? key}) : super(key: key);

  @override
  State<CreateStory> createState() => _CreateStoryState();
}

class _CreateStoryState extends State<CreateStory> {
  final CreateStoryController controller = Get.put(CreateStoryController());

  final List<String> storyTypeOptions = ['Text', 'Image'];
  final List<String> privacyOptions = ['Public', 'Friends', 'Only me'];

  final Color darkBackground = const Color(0xFF121212);
  final Color darkCard = const Color(0xFF1E1E1E);
  final Color primaryText = Colors.white;
  final Color secondaryText = Colors.grey;
  final Color iconColor = Colors.purpleAccent;

  @override
  void dispose() {
    Get.delete<CreateStoryController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
        elevation: 1,
        title: Text(
          'Create Story',
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
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _userRow(),
              const SizedBox(height: 12),

              // Story Type Dropdown
              Text(
                "Story Type",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 6),
              Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: darkCard,
                      value: controller.selectedStoryType.value,
                      icon: Icon(Icons.arrow_drop_down, color: secondaryText),
                      items: storyTypeOptions.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Row(
                            children: [
                              Icon(
                                type == 'Text'
                                    ? Icons.text_fields
                                    : Icons.image_outlined,
                                size: 18,
                                color: secondaryText,
                              ),
                              const SizedBox(width: 4),
                              Text(type,
                                  style: TextStyle(color: secondaryText)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedStoryType.value = value;
                        }
                      },
                    ),
                  )),

              const SizedBox(height: 12),

              // Privacy Dropdown
              Text(
                "Privacy",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 6),
              Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: darkCard,
                      value: controller.selectedPrivacy.value,
                      icon: Icon(Icons.arrow_drop_down, color: secondaryText),
                      items: privacyOptions.map((option) {
                        return DropdownMenuItem(
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
                              Text(option,
                                  style: TextStyle(color: secondaryText)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedPrivacy.value = value;
                        }
                      },
                    ),
                  )),

              const SizedBox(height: 16),

              // Content Area
              Obx(() {
                if (controller.selectedStoryType.value == 'Image') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _iconRow(),
                      const SizedBox(height: 8),
                      if (controller.pickedImages.isNotEmpty) _imageGrid(),
                    ],
                  );
                } else {
                  return _descriptionField();
                }
              }),
            ],
          ),
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
          child: Icon(icon, color: iconColor, size: 22),
        ),
      ),
    );
  }

  Widget _imageGrid() {
    return SizedBox(
      height: 230,
      child: GridView.builder(
        itemCount: controller.pickedImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
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
  }

  Widget _userRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AuthController.instance.currentUser?.photo != null
              ? CachedNetworkImageProvider(
                  AuthController.instance.currentUser!.photo,
                )
              : const AssetImage('assets/images/profile_placeholder.png')
                  as ImageProvider,
        ),
        const SizedBox(width: 10),
        Text(
          AuthController.instance.currentUser?.name ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: primaryText,
          ),
        ),
      ],
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      controller: controller.descriptionController,
      maxLines: 6,
      style: TextStyle(color: primaryText),
      decoration: InputDecoration(
        hintText: "Write something for your story...",
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
            await controller.uploadStroy(CreateStoryModel(
              contentType: "image",
              publisher: "user",
              storyFilePath: controller.pickedImages.first.path,
              privacy: controller.selectedPrivacy.value.toLowerCase(),
              description: controller.descriptionController.text,
            ));
            Fluttertoast.showToast(msg: "Story uploaded");
            Get.back(result: true);
          } catch (e) {
            Fluttertoast.showToast(msg: "Error: $e");
          }
        },
        child: Obx(() => controller.isLoading.value
            ? const CircularProgressIndicator.adaptive()
            : Text(
                'Publish Now',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )),
      ),
    );
  }
}
