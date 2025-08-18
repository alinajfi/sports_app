// home_view.dart
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/home_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/social_media_post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/services/home_services.dart';
import 'package:prime_social_media_flutter_ui_kit/services/payment_service.dart';
import 'package:prime_social_media_flutter_ui_kit/services/social_service.dart';
import 'package:prime_social_media_flutter_ui_kit/services/third_party_login_service.dart';
import 'package:prime_social_media_flutter_ui_kit/services/user_service.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/home_app_bar.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/my_drawer.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/post_item.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/repost_item.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/stories_section.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/text_post.dart';
import 'package:prime_social_media_flutter_ui_kit/views/new_post/reel/create_reel_view.dart';

import '../../services/notification_service.dart';

// import '../../services/notification_service.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());

  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        // floatingActionButton: _buildFloatingActionButton(),
        endDrawer: MyDrawer(),
        backgroundColor: AppColor.backgroundColor,
        appBar: HomeAppBar(scaffoldKey: _scaffoldKey),
        body: _buildBody(),
      ),
    );
  }

  // Future<void> makePayment() async {
  //   final clientSecret = await PaymentService().createPaymentIntent();

  //   await Stripe.instance.initPaymentSheet(
  //     paymentSheetParameters: SetupPaymentSheetParameters(
  //       paymentIntentClientSecret: clientSecret,
  //       merchantDisplayName: 'Test Store',
  //     ),
  //   );

  //   await Stripe.instance.presentPaymentSheet();
  // }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        // makePayment();
        // final token = await FirebaseMessaging.instance.getToken();
        // NotificationService().sendNotification(token!, "Test ", "Test");
        //   SocialService().getFriendRequest();
        // SocialService().getFrinds();

        // homeController.getLoggedInUserPost();
        // var resul = await HomeServices().getLoggedInUserPost();
        //  log(resul.toString());

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
          SizedBox(
            height: AppSize.appSize30,
          ),
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
                .map((post) => GetBuilder<HomeController>(
                    id: 'on_like',
                    builder: (cont) {
                      return PostItem(
                        commentsCount: post.commentsCount.toString(),
                        reactionCount:
                            post.reactionCounts?.love.toString() ?? "0",
                        controller: Get.find<HomeController>(),
                        socialPost: post,
                        onLike: () {
                          final postId = post.postId.toString();
                          final homeController = Get.find<HomeController>();

                          if (homeController.favIds.contains(postId)) {
                            homeController.favIds.remove(postId);
                            DbController.instance.writeData<List>(
                                DbConstants.itemAddedToFav,
                                homeController.favIds.toList());
                            cont.update(
                                ['on_like', 'actions', 'update_all_actions']);
                          } else {
                            final index = homeController.timeLinePosts
                                .indexWhere((p) => p.postId == post.postId);

                            if (index != -1) {
                              homeController
                                  .addReactionToPost(postId, index)
                                  .then((success) {
                                if (success) {
                                  homeController.favIds.add(postId);
                                  DbController.instance.writeData(
                                      DbConstants.itemAddedToFav,
                                      homeController.favIds.toList());
                                  cont.update([
                                    'on_like',
                                    'actions',
                                    'update_all_actions'
                                  ]);
                                }
                              });
                            } else {
                              log('⚠️ Post not found in timeline for liking.');
                            }
                          }
                        },
                        isLiked:
                            homeController.isFavourite(post.postId.toString()),
                      );
                    })),

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
