// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class ReelsPlayController extends GetxController {
  VideoPlayerController? videoPlayerController;
  RxBool isInitialised = false.obs;
  RxBool isVideoPlaying = false.obs;
  RxBool isFollow = false.obs;
  RxBool isLiked = false.obs;
  RxBool isExpanded = false.obs;

  PageController pageController = PageController();

  RxInt currentReelIndex = 0.obs;
  RxBool showHeartIcon = false.obs;

  VideoPlayerController? get controller => videoPlayerController;

  Future<void> shareAssetVideo(String assetPath, {String? text}) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/shared_video.mp4');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      await Share.shareXFiles([XFile(file.path)], text: text);
    } catch (e) {
      print("Error sharing video: $e");
    }
  }

  Future<void> openCamera() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {

    }
  }

  void toggleFollow() {
    isFollow.value = !isFollow.value;
  }

  void toggleLike() {
    bool wasLiked = isLiked.value;
    isLiked.value = !isLiked.value;

    if (isLiked.value && !wasLiked) {
      showHeartIcon.value = true;

      Future.delayed(const Duration(seconds: AppSize.size2), () {
        showHeartIcon.value = false;
      });
    }
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void onPageChanged(int index) {
    if (index != currentReelIndex.value) {
      currentReelIndex.value = index;
    }
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }
}