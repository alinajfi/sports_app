import 'dart:io';

import 'package:flutter/material.dart' show TextEditingController;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prime_social_media_flutter_ui_kit/model/create_post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/services/home_services.dart';

import '../model/create_story_model.dart';

class CreateStoryController extends GetxController {
  var selectedStoryType = 'Image'.obs;
  var selectedPrivacy = 'Public'.obs;

  TextEditingController descriptionController = TextEditingController();

  var pickedImages = <File>[].obs;

  RxBool isLoading = false.obs;

  var tagPeople;

  var pickLocation;

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      pickedImages.clear(); // Clear previous selection if needed
      pickedImages.addAll(images.map((xfile) => File(xfile.path)));
    }
  }

  uploadStroy(CreateStoryModel stroyData) async {
    isLoading.value = true;
    await HomeServices().createStory(stroyData);
    isLoading.value = false;
  }
}
