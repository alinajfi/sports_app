// home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/home_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/social_media_post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/home_app_bar.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/my_drawer.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/post_item.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/repost_item.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/stories_section.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/text_post.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: _buildFloatingActionButton(),
        endDrawer: MyDrawer(),
        backgroundColor: AppColor.backgroundColor,
        appBar: HomeAppBar(scaffoldKey: _scaffoldKey),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // UserService().getUserPosts();
        // PostService().getPostOnTimeLine();
        // _scaffoldKey.currentState?.openDrawer();
      },
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        children: [
          StoriesSection(),
          _buildPostsList(),
        ],
      ),
    );
  }

  Widget _buildPostsList() {
    return Obx(
      () {
        return Column(
          children: [
            ...Get.find<HomeController>()
                .timeLinePosts
                .value
                .map((post) => PostItem(
                      socialPost: post,
                      onLike: () => homeController.toggleLike(),
                      isLiked: homeController.isLiked,
                    )),

            // Text post
            // TextPostItem(
            //   onLike: () => homeController.toggleLike1(),
            //   isLiked: homeController.isLiked1,
            // ),

            // Another post with image
            // PostItem(
            //   socialPost: posts.first, // Using first post as example
            //   onLike: () => homeController.toggleLike2(),
            //   isLiked: homeController.isLiked2,
            // ),

            // Another text post
            // TextPostItem(
            //   onLike: () => homeController.toggleLike3(),
            //   isLiked: homeController.isLiked3,
            // ),

            // Repost items
            // RepostItem(
            //   imagePath:
            //       'assets/images/post4.png', // Replace with AppImage.post4
            //   onLike: () => homeController.toggleLike4(),
            //   isLiked: homeController.isLiked4,
            // ),

            // RepostItem(
            //   imagePath:
            //       'assets/images/post5.png', // Replace with AppImage.post5
            //   onLike: () => homeController.toggleLike4(),
            //   isLiked: homeController.isLiked4,
            // ),
          ],
        );
      },
    );
  }
}
