import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prime_social_media_flutter_ui_kit/model/create_post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/services/home_services.dart';
import '../../model/post_model.dart';

class EditPostController extends GetxController {
  final PostModel post;
  EditPostController(this.post);

  late TextEditingController descriptionController;
  @override
  onInit() {
    super.onInit();
    descriptionController = TextEditingController(text: post.description);
    if (post.photo != null && post.photo!.isNotEmpty) {
      existingImages.assignAll(post.postImages!);
    }
  }

  RxBool isSwitchLike = false.obs;
  RxBool isSwitchComment = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  RxList<String> taggedPeople = RxList<String>();
  RxString selectedFeeling = ''.obs;
  RxString location = ''.obs;
  RxString event = ''.obs;
  var existingImages = <String>[].obs;

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  Future<void> pickLocation() async {
    // You can integrate Google Maps or simple dialog
    location.value = "Lahore, Pakistan"; // example
  }

  Future<void> tagPeople() async {
    // You can navigate to another screen or use a dialog
    taggedPeople.value = ["Ali", "Zainab"];
  }

  @override
  void dispose() {
    super.dispose();
    descriptionController.clear();
  }

  void toggleLike() {
    isSwitchLike.value = !isSwitchLike.value;
  }

  void toggleComment() {
    isSwitchComment.value = !isSwitchComment.value;
  }

  // pickMediaFiles() {
  //   log("jfaksldjfklasdjfajsfkjaskflkas");
  // }

  var pickedFiles = <PlatformFile>[].obs;
  var pickedImages = <File>[].obs;

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      pickedImages.clear(); // Clear previous selection if needed
      pickedImages.addAll(images.map((xfile) => File(xfile.path)));
    }
  }

  Future<void> pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      pickedFiles.assignAll(result.files);
    }
  }

  RxBool isLoading = false.obs;
  Future<void> editPost(CreatePostModel postData) async {
    isLoading.value = true;
    await HomeServices().editPost(postData, postId: post.postId!.toString());

    isLoading.value = false;
  }
}
