import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

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

  Future<void> pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      // Access list of selected files
      List<PlatformFile> files = result.files;

      for (var file in files) {
        print('File name: ${file.name}');
        print('File path: ${file.path}');
      }
    } else {
      print('No files selected.');
    }
  }

  Future<void> uploadPost(CreatePostModel postData) async {
    final response = await toMultipartRequest(
        Uri.parse("${ApiConstants.baseUrl}/create_post"), postData);
    final st = await response.send();
    final res = await http.Response.fromStream(st);
    log(res.body.toString());
    if (res.statusCode == 200) {}
  }

  Future<http.MultipartRequest> toMultipartRequest(
      Uri uri, CreatePostModel postData) async {
    final request = http.MultipartRequest('POST', uri);

    request.headers.addAll(CommonApiFunctions().getHeadersWithTokenJson()!);

    // Required
    request.fields['privacy'] = postData.privacy;

    // Optional fields
    if (postData.description != null) {
      request.fields['description'] = postData.description!;
    }

    if (postData.taggedUsersId != null) {
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

    request.fields['publisher'] = postData.publisher;

    if (postData.eventId != null) {
      request.fields['event_id'] = postData.eventId.toString();
    }

    if (postData.pageId != null) {
      request.fields['page_id'] = postData.pageId.toString();
    }

    if (postData.groupId != null) {
      request.fields['group_id'] = postData.groupId.toString();
    }

    request.fields['post_type'] = postData.postType;

    // Files
    if (postData.multipleFiles != null) {
      for (var file in postData.multipleFiles!) {
        final multipartFile = await http.MultipartFile.fromPath(
          'multiple_files[]',
          file.path,
          filename: basename(file.path),
        );
        request.files.add(multipartFile);
      }
    }

    if (postData.mobileAppImage != null) {
      final imageFile = await http.MultipartFile.fromPath(
        'mobile_app_image',
        postData.mobileAppImage!.path,
        filename: basename(postData.mobileAppImage!.path),
      );
      request.files.add(imageFile);
    }

    return request;
  }
}
