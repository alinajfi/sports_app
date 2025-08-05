// ignore_for_file: deprecated_member_use
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/comment_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/services/home_services.dart';
import 'package:share_plus/share_plus.dart';

class HomeController extends GetxController {
  RxList<PostModel> timeLinePosts = <PostModel>[].obs;

  Rx<int> selectedLabelIndex = Rx<int>(0);
  RxDouble progress = 0.0.obs;

  getTimeLinePosts() async {
    try {
      timeLinePosts.value = await HomeServices().fetchTimelinePosts();
    } catch (e) {
      timeLinePosts.value = [];
      log("error getting timeline posts$e");
    }
  }

  Future<bool> addReactionToPost(String postId) async {
    final result = await HomeServices().addReactionToPost(postId: postId);
    getReactions(postId);
    return result;
  }

  getReactions(String postId) {
    HomeServices().getPostReactions(postId: postId);
  }

  bool isFavourite(String postId) {
    return favIds.contains(postId);
  }

  Set<String> favIds = {};
  @override
  void onInit() {
    super.onInit();
    getTimeLinePosts();
    final storedList =
        DbController.instance.readData(DbConstants.itemAddedToFav);
    favIds = storedList != null ? Set<String>.from(storedList) : {};
    HomeServices().getAllUsers();
  }

  getUserProifleWithId() async {
    final result = await HomeServices().getUserProfileWithId(userId: "12");
  }

  void startAnimation() async {
    await Future.delayed(const Duration(seconds: AppSize.size2));
    Get.back();
  }

  Future<void> shareAssetImage(String assetPath, {String? text}) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/shared_image.png');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      await Share.shareXFiles(
        [XFile(file.path)],
        text: text,
      );
    } catch (e) {
      print('Error sharing image: $e');
    }
  }

  HomeController() {
    selectLabel(0);
  }

  bool isLabelSelected(int index) {
    return selectedLabelIndex.value == index;
  }

  void selectLabel(int index) {
    selectedLabelIndex.value = index;
    update();
  }

  RxList<String> storyList = [
    AppImage.myStory,
    AppImage.story1,
    AppImage.story2,
    AppImage.story3,
    AppImage.story1,
    AppImage.story2,
    AppImage.story3,
    AppImage.story1,
    AppImage.story2,
    AppImage.story3,
  ].obs;

  RxList<String> storyIDList = [
    AppString.yourStory,
    AppString.sabsa01,
    AppString.blueBouy,
    AppString.wagglesCo,
    AppString.sabsa01,
    AppString.blueBouy,
    AppString.wagglesCo,
    AppString.sabsa01,
    AppString.blueBouy,
    AppString.wagglesCo,
  ].obs;
}
