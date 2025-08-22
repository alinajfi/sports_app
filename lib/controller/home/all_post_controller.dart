import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:http/http.dart' as http;
import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';

class AllPostController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  RxBool isFollow = false.obs;
  RxBool isLiked = false.obs;
  RxInt selectedTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      initialIndex: AppSize.size0,
      length: AppSize.size4,
      vsync: this,
    );
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  void toggleFollow() {
    isFollow.value = !isFollow.value;
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  RxList<String> postsList = [
    AppString.post1,
    AppString.post2,
    AppString.post3,
    AppString.post4,
    AppString.post5,
    AppString.post6,
    AppString.post7,
    AppString.post8,
    AppString.post9,
    AppString.post1,
    AppString.post2,
    AppString.post3,
    AppString.post4,
    AppString.post5,
    AppString.post6,
    AppString.post7,
    AppString.post8,
    AppString.post9,
  ].obs;

  RxList<String> reelsList = [
    AppString.reel1,
    AppString.reel2,
    AppString.reel3,
    AppString.reel4,
    AppString.reel5,
    AppString.reel6,
    AppString.reel7,
    AppString.reel8,
    AppString.reel9,
  ].obs;

  RxList<String> reelsViewList = [
    AppString.reelView500,
    AppString.reelView500k,
    AppString.reelView100k,
    AppString.reelView5and5k,
    AppString.reelView20k,
    AppString.reelView389,
    AppString.reelView1m,
    AppString.reelView2and5m,
    AppString.reelView78,
  ].obs;

  Future<bool> deletePost(
    int id,
  ) async {
    final url = Uri.parse('https://mysportsjourney.co.uk/api/delete_post/$id');

    try {
      final response = await http.post(url,
          headers: CommonApiFunctions().getHeaderWithToken());

      print("Delete API Status: ${response.statusCode}");
      print("Delete API Body: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error deleting post: $e");
      return false;
    }
  }

  // Future<bool> editPost(
  //   int id,
  // ) async {
  //   final url = Uri.parse('https://mysportsjourney.co.uk/api/edit_post/$id');

  //   try {
  //     final response = await http.post(url,
  //         headers: CommonApiFunctions().getHeaderWithToken());

  //     print("Delete API Status: ${response.statusCode}");
  //     print("Delete API Body: ${response.body}");

  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Error deleting post: $e");
  //     return false;
  //   }
  // }
}
