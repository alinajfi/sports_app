// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/auth_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/main.dart';
import 'package:prime_social_media_flutter_ui_kit/model/comment_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/story_model.dart';
import 'package:prime_social_media_flutter_ui_kit/services/home_services.dart';
import 'package:share_plus/share_plus.dart';

class HomeController extends GetxController {
  final homeService = HomeServices();
  RxList<PostModel> timeLinePosts = <PostModel>[].obs;

  Rx<int> selectedLabelIndex = Rx<int>(0);
  RxDouble progress = 0.0.obs;

  getTimeLinePosts() async {
    isLoading.value = true;
    try {
      timeLinePosts.value = await HomeServices().fetchTimelinePosts();
      isLoading.value = false;
    } catch (e) {
      timeLinePosts.value = [];
      log("error getting timeline posts$e");
      isLoading.value = false;
    }
  }

  Future<bool> addReactionToPost(String postId, int index) async {
    try {
      final result = await HomeServices().addReactionToPost(postId: postId);

      final posts = await homeService.fetchTimelinePosts();

      final updatedPost = posts.firstWhereOrNull(
        (element) => element.postId.toString() == postId,
      );

      if (updatedPost == null) {
        log('❌ Post with ID $postId not found in fetched posts.');
        return result;
      }

      final timelineIndex = timeLinePosts.indexWhere(
        (post) => post.postId.toString() == postId,
      );

      if (timelineIndex == -1) {
        log('⚠️ Post with ID $postId not found in current timeline list.');
      } else {
        timeLinePosts[timelineIndex] = updatedPost;
        log('✅ Post at index $timelineIndex updated after reaction.');
      }

      return result;
    } catch (e, stackTrace) {
      log('💥 Exception in addReactionToPost: $e');
      log('🔍 StackTrace: $stackTrace');
      return false;
    }
  }

  getReactions(String postId) {
    HomeServices().getPostReactions(postId: postId);
  }

  Future<void> getPostAfterComment({required String postId}) async {
    final posts = await homeService.fetchTimelinePosts();

    final updatedPost = posts.firstWhereOrNull(
      (element) => element.postId.toString() == postId,
    );

    if (updatedPost != null) {
      // Look for index in timeLinePosts using a matching condition
      final index = timeLinePosts.indexWhere(
        (post) => post.postId == updatedPost.postId,
      );

      if (index != -1) {
        timeLinePosts[index] = updatedPost;
        log('✅ Post updated at index $index: ${updatedPost.toString()}');
      } else {
        log('⚠️ Post with ID $postId not found in current timeline list');
      }
    } else {
      log('❌ Post with ID $postId not found in fetched posts');
    }
  }

  bool isFavourite(String postId) {
    return favIds.contains(postId);
  }

  Set favIds = {};
  @override
  void onInit() {
    super.onInit();
    try {
      getUserIfNull();
      getTimeLinePosts();
      final storedList =
          DbController.instance.readData(DbConstants.itemAddedToFav);
      favIds = storedList != null ? Set.from(storedList) : {};
      HomeServices().getAllUsers();
      getStories();
    } catch (e) {
      log(e.toString());
    }
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

  // HomeController() {
  //   selectLabel(0);
  // }

  bool isLabelSelected(int index) {
    return selectedLabelIndex.value == index;
  }

  void selectLabel(int index) {
    selectedLabelIndex.value = index;
    update();
  }

  RxBool isLoading = false.obs;
  Future<void> getStories() async {
    isLoading.value = true;
    try {
      storyList.value = await homeService.getStories();
    } catch (e) {
      isLoading.value = false;
      log("error fetching stories $e ");
    }
    isLoading.value = false;
  }

  RxList<StoryModel> storyList = <StoryModel>[].obs;

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

  Future<void> getUserIfNull() async {
    if (AuthController.instance.currentUser == null) {
      await AuthController.instance.getCurrentUser();
    }
  }
}
