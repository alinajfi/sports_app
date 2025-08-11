import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:http_parser/http_parser.dart';

import 'package:mime/mime.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/api_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/model/create_post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';

class CreatePostController extends GetxController {
  TextEditingController descriptionController = TextEditingController();

  RxBool isSwitchLike = false.obs;
  RxBool isSwitchComment = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  RxList<String> taggedPeople = RxList<String>();
  RxString selectedFeeling = ''.obs;
  RxString location = ''.obs;
  RxString event = ''.obs;

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

  // Future<void> uploadPost(CreatePostModel model) async {
  //   // Add your API logic here
  //   debugPrint("Uploading: ${model.description}, Image: ${model.multipleFiles}");
  // }

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
  Future<void> uploadPost(CreatePostModel postData) async {
    isLoading.value = true;
    await addPostWithMultipart(
        Uri.parse("${ApiConstants.baseUrl}/create_post"), postData);
    isLoading.value = false;
  }

  Future<bool> addPostWithMultipart(
    Uri uri,
    CreatePostModel postData,
  ) async {
    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(CommonApiFunctions().getHeadersWithTokenJson()!);

    // Required Fields
    request.fields['privacy'] = postData.privacy;
    request.fields['publisher'] = postData.publisher;
    request.fields['post_type'] = postData.postType;

    // Optional Fields
    if (postData.description != null) {
      request.fields['description'] = postData.description!;
    }

    if (postData.taggedUsersId != null && postData.taggedUsersId!.isNotEmpty) {
      for (var id in postData.taggedUsersId!) {
        request.fields['tagged_users_id[]'] = id.toString();
      }
    }

    if (postData.feelingAndActivityId != null) {
      request.fields['feeling_and_activity_id'] =
          postData.feelingAndActivityId.toString();
    }

    if (postData.address != null) {
      request.fields['address'] = postData.address!;
    }

    if (postData.eventId != null) {
      request.fields['event_id'] = postData.eventId.toString();
    }

    if (postData.pageId != null) {
      request.fields['page_id'] = postData.pageId.toString();
    }

    if (postData.groupId != null) {
      request.fields['group_id'] = postData.groupId.toString();
    }

    // 🔄 Upload multiple files as 'pictures[]'
    if (postData.multipleFiles != null && postData.multipleFiles!.isNotEmpty) {
      for (final file in postData.multipleFiles!) {
        if (file.existsSync()) {
          final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
          final mimeTypeSplit = mimeType.split('/');
          final multipartFile = await http.MultipartFile.fromPath(
            'multiple_files[]', // <-- Make sure this matches backend key!
            file.path,
            contentType: MediaType(mimeTypeSplit[0], mimeTypeSplit[1]),
            filename: basename(file.path),
          );
          request.files.add(multipartFile);
          log('📷 Attached file to pictures[]: ${file.path}');
        } else {
          log('❌ Skipped file (does not exist): ${file.path}');
        }
      }
    }

    // 🔄 Also add first image as 'mobile_app_image'
    if (postData.multipleFiles != null && postData.multipleFiles!.isNotEmpty) {
      final firstFile = postData.multipleFiles!.first;
      if (firstFile.existsSync()) {
        final mimeType = lookupMimeType(firstFile.path) ?? 'image/jpeg';
        final mimeTypeSplit = mimeType.split('/');
        final imageFile = await http.MultipartFile.fromPath(
          'mobile_app_image',
          firstFile.path,
          contentType: MediaType(mimeTypeSplit[0], mimeTypeSplit[1]),
          filename: basename(firstFile.path),
        );
        request.files.add(imageFile);
        log("📷 Attached file to mobile_app_image: ${firstFile.path}");
      }
    }

    // 🧾 Log all fields
    log('📝 Request Fields: ${request.fields}');
    log('➡️ Sending multipart request to: ${uri.toString()}');

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('✅ Response Code: ${response.statusCode}');
      log('🧾 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        return false;
      } else {
        return false;
      }
    } catch (e) {
      log("❌ Error sending multipart post: $e");
      return false;
    }
  }

  RxList<String> existingImageUrls = <String>[].obs;

  Future<bool> editPost({
    required int postId,
    required String description,
    required List<File> newImages,
    required List<String> remainingOldImages,
  }) async {
    final url =
        Uri.parse('https://mysportsjourney.co.uk/api/edit_post/$postId');

    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(CommonApiFunctions().getHeaderWithToken()!)
      ..fields['description'] = description;

    // Keep old images
    for (var url in remainingOldImages) {
      request.fields['keep_images[]'] = url;
    }

    // Add new files
    for (var file in newImages) {
      request.files.add(
        await http.MultipartFile.fromPath('images[]', file.path),
      );
    }

    final response = await request.send();
    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
