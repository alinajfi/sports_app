import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/post_model.dart';

class EditPostController extends GetxController {
  final PostModel post;
  EditPostController(this.post);

  final descriptionController = TextEditingController();
  final imagePaths = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    descriptionController.text = post.description ?? '';
    imagePaths.assignAll(post.postImages ?? []);
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePaths.clear();
      imagePaths.add(pickedFile.path);
    }
  }

  void savePost() {
    // 🔹 Call your API to save changes here
    Get.back(result: true); // Return true so parent can refresh
  }
}
