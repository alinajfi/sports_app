import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/create_post_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';

class EditPostScreen extends StatelessWidget {
  final PostModel post;

  EditPostScreen({Key? key, required this.post}) : super(key: key);

  final CreatePostController controller = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    // Pre-fill controller with existing description
    controller.descriptionController.text = post.description ?? "";
    final imageUrl =
        (post.postImages!.isNotEmpty) ? post.postImages!.first : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Post"),
        backgroundColor: AppColor.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // controller.createPost(); // Same as create post
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Show existing image if available
            if (post.postImages != null && post.postImages!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  post.postImages!.first,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 16),

            // Allow picking a new image
            Obx(() {
              return Column(
                children: [
                  if (controller.selectedImage.value != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(controller.selectedImage.value!.path),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: controller.pickImage,
                    child: const Text("Change Image"),
                  ),
                ],
              );
            }),

            const SizedBox(height: 16),

            // Description
            TextField(
              controller: controller.descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Write something...",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
