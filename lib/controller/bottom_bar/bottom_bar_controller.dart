import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/home_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/new_post/post/create_post.dart';
import 'package:prime_social_media_flutter_ui_kit/views/notification/notifications_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/profile/profile_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/reels/reels_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/new_post/new_post_options_bottom_sheet.dart';

class BottomBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
  }

  void changeSelectedIndex(BuildContext context, int index) {
    selectedIndex.value = index;
    if (selectedIndex.value == 2) {
      selectedIndex.value = 0;
      Get.to(CreatePostScreen());
      // newPostOptionsBottomSheet(context);
    }
    pageController.jumpToPage(selectedIndex.value);
    update();
  }

  RxList<Widget> pages = [
    HomeView(),
    NotificationsView(),
    // // ReelsView(),
    Container(),

    ProfileView(),
  ].obs;
}
