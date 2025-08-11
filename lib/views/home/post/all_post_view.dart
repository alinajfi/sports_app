// ignore_for_file: must_be_immutable
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/all_post_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/post/tabs/comments_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/post/tabs/posts_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/post/tabs/reels_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/post/tabs/tags_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/home/user_action_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_size.dart';

class AllPostView extends StatelessWidget {
  AllPostView({Key? key}) : super(key: key);

  AllPostController allPostController = Get.put(AllPostController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(context),
      body: _body(),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(
          left: languageController.selectedLanguageIndex.value == AppSize.size2
              ? AppSize.appSize0
              : AppSize.appSize20,
          right: languageController.selectedLanguageIndex.value == AppSize.size2
              ? AppSize.appSize20
              : AppSize.appSize0,
          top: AppSize.appSize6,
        ),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            languageController.selectedLanguageIndex.value == AppSize.size2
                ? AppIcon.backRight
                : AppIcon.back,
          ),
        ),
      ),
      leadingWidth: AppSize.appSize44,
      title: const Text(
        AppString.eleanorPenaID,
        style: TextStyle(
          fontSize: AppSize.appSize20,
          fontWeight: FontWeight.w600,
          fontFamily: AppFont.appFontSemiBold,
          color: AppColor.secondaryColor,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: AppSize.appSize20,
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize16
                    : AppSize.appSize0,
          ),
          child: GestureDetector(
            onTap: () {
              userActionBottomSheet(context);
            },
            child: SizedBox(
              width: AppSize.appSize20,
              child: Image.asset(
                AppIcon.info,
                height: AppSize.appSize14,
                width: AppSize.appSize3,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // _body() {
  //   return NestedScrollView(
  //     headerSliverBuilder: (context, innerBoxIsScrolled) {
  //       return [
  //         SliverList(
  //           delegate: SliverChildListDelegate(
  //             [
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                   top: AppSize.appSize35,
  //                   left: AppSize.appSize20,
  //                   right: AppSize.appSize20,
  //                 ),
  //                 child: Column(
  //                   children: [
  //                     Align(
  //                       alignment: Alignment.topCenter,
  //                       child: Column(
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.only(bottom: AppSize.appSize16),
  //                             child: GestureDetector(
  //                               onTap: () {
  //                                 Get.toNamed(AppRoutes.storyWithMessageView);
  //                               },
  //                               child: Image.asset(
  //                                 AppImage.story2,
  //                                 width: AppSize.appSize82,
  //                               ),
  //                             ),
  //                           ),
  //                           const Padding(
  //                             padding: EdgeInsets.only(bottom: AppSize.appSize18),
  //                             child: Text(
  //                               AppString.eleanorPena,
  //                               style: TextStyle(
  //                                 fontSize: AppSize.appSize16,
  //                                 fontWeight: FontWeight.w600,
  //                                 fontFamily: AppFont.appFontSemiBold,
  //                                 color: AppColor.secondaryColor,
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: AppSize.appSize50,
  //                             width: AppSize.appSize230,
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 _customPostFollowersFollowingCount(AppString.posts176, AppString.posts),
  //                                 _customPostFollowersFollowingCount(AppString.followers200k, AppString.followers),
  //                                 _customPostFollowersFollowingCount(AppString.following1123, AppString.following),
  //                               ],
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(top: AppSize.appSize18, bottom: AppSize.appSize16),
  //                             child: SizedBox(
  //                               height: AppSize.appSize32,
  //                               width: AppSize.appSize290,
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   GestureDetector(
  //                                     onTap: () {
  //                                       allPostController.toggleFollow();
  //                                     },
  //                                     child: Obx(() => Container(
  //                                       width: AppSize.appSize110,
  //                                       height: AppSize.appSize32,
  //                                       decoration: BoxDecoration(
  //                                         borderRadius: BorderRadius.circular(AppSize.appSize6),
  //                                         color: allPostController.isFollow.value
  //                                             ? AppColor.cardBackgroundColor
  //                                             : AppColor.primaryColor,
  //                                       ),
  //                                       child: Center(
  //                                         child: Text(
  //                                           allPostController.isFollow.value ? AppString.following : AppString.follow,
  //                                           style: const TextStyle(
  //                                             fontSize: AppSize.appSize14,
  //                                             fontWeight: FontWeight.w600,
  //                                             fontFamily: AppFont.appFontSemiBold,
  //                                             color: AppColor.secondaryColor,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     )),
  //                                   ),
  //                                   GestureDetector(
  //                                     onTap: () {
  //                                       Share.share(AppString.eleanorPena);
  //                                     },
  //                                     child: Container(
  //                                       width: AppSize.appSize110,
  //                                       height: AppSize.appSize32,
  //                                       decoration: BoxDecoration(
  //                                         borderRadius: BorderRadius.circular(AppSize.appSize6),
  //                                         color: AppColor.cardBackgroundColor,
  //                                       ),
  //                                       child: const Center(
  //                                         child: Text(
  //                                           AppString.shareProfile,
  //                                           style: TextStyle(
  //                                             fontSize: AppSize.appSize14,
  //                                             fontWeight: FontWeight.w600,
  //                                             fontFamily: AppFont.appFontSemiBold,
  //                                             color: AppColor.secondaryColor,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   GestureDetector(
  //                                     onTap: () {
  //                                       Fluttertoast.showToast(
  //                                         msg: AppString.userAdded,
  //                                         toastLength: Toast.LENGTH_SHORT,
  //                                         gravity: ToastGravity.BOTTOM,
  //                                         timeInSecForIosWeb: AppSize.size1,
  //                                         backgroundColor: AppColor.cardBackgroundColor,
  //                                         textColor: AppColor.secondaryColor,
  //                                         fontSize: AppSize.appSize14,
  //                                       );
  //                                     },
  //                                     child: Container(
  //                                       width: AppSize.appSize40,
  //                                       height: AppSize.appSize32,
  //                                       decoration: BoxDecoration(
  //                                         borderRadius: BorderRadius.circular(AppSize.appSize6),
  //                                         color: AppColor.cardBackgroundColor,
  //                                       ),
  //                                       child: Center(
  //                                         child: Image.asset(
  //                                           AppIcon.add,
  //                                           width: AppSize.appSize20,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                           const Text(
  //                             AppString.loremString5,
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                               fontSize: AppSize.appSize14,
  //                               fontWeight: FontWeight.w400,
  //                               fontFamily: AppFont.appFontRegular,
  //                               color: AppColor.secondaryColor,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(top: AppSize.appSize36, bottom: AppSize.appSize32),
  //                       child: Row(
  //                         children: [
  //                           _customHighlights(AppImage.highlight1, AppString.like),
  //                           _customHighlights(AppImage.highlight2, AppString.travel),
  //                         ],
  //                       ),
  //                     ),
  //                     Obx(() {
  //                       return TabBar(
  //                         onTap: (val) {
  //                           allPostController.selectedTabIndex.value = val;
  //                         },
  //                         controller: allPostController.tabController,
  //                         dividerColor: AppColor.backgroundColor,
  //                         labelColor: AppColor.secondaryColor,
  //                         labelStyle: const TextStyle(
  //                           color: AppColor.secondaryColor,
  //                         ),
  //                         unselectedLabelColor: AppColor.text1Color,
  //                         indicatorColor: AppColor.secondaryColor,
  //                         indicatorSize: TabBarIndicatorSize.tab,
  //                         indicatorWeight: AppSize.appSizePoint7,
  //                         isScrollable: false,
  //                         tabs: [
  //                           Tab(
  //                             icon: Image.asset(
  //                               AppIcon.photos,
  //                               width: AppSize.appSize22,
  //                               color: allPostController.selectedTabIndex.value == 0
  //                                   ? AppColor.secondaryColor
  //                                   : AppColor.text1Color,
  //                             ),
  //                           ),
  //                           Tab(
  //                             icon: Image.asset(
  //                               AppIcon.editComment,
  //                               width: AppSize.appSize22,
  //                               color: allPostController.selectedTabIndex.value == 1
  //                                   ? AppColor.secondaryColor
  //                                   : AppColor.text1Color,
  //                             ),
  //                           ),
  //                           Tab(
  //                             icon: Image.asset(
  //                               AppIcon.reel,
  //                               width: AppSize.appSize22,
  //                               color: allPostController.selectedTabIndex.value == 2
  //                                   ? AppColor.secondaryColor
  //                                   : AppColor.text1Color,
  //                             ),
  //                           ),
  //                           Tab(
  //                             icon: Image.asset(
  //                               AppIcon.tag,
  //                               width: AppSize.appSize22,
  //                               color: allPostController.selectedTabIndex.value == 3
  //                                   ? AppColor.secondaryColor
  //                                   : AppColor.text1Color,
  //                             ),
  //                           ),
  //                         ],
  //                       );
  //                     }),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ];
  //     },
  //     body: TabBarView(
  //       physics: const NeverScrollableScrollPhysics(),
  //       controller: allPostController.tabController,
  //       children: [
  //         PostsTabView(),
  //         const CommentsTabView(),
  //         ReelsTabView(),
  //         TagsTabView(),
  //       ],
  //     ),
  //   );
  // }

  _body() {
    return DefaultTabController(
      length: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.appSize35,
                    left: AppSize.appSize20,
                    right: AppSize.appSize20,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppSize.appSize16),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.storyWithMessageView);
                                },
                                child: Image.asset(
                                  AppImage.story2,
                                  width: AppSize.appSize82,
                                ),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(bottom: AppSize.appSize18),
                              child: Text(
                                AppString.eleanorPena,
                                style: TextStyle(
                                  fontSize: AppSize.appSize16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFont.appFontSemiBold,
                                  color: AppColor.secondaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AppSize.appSize50,
                              width: AppSize.appSize230,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _customPostFollowersFollowingCount(
                                      AppString.posts176, AppString.posts),
                                  _customPostFollowersFollowingCount(
                                      AppString.followers200k,
                                      AppString.followers),
                                  _customPostFollowersFollowingCount(
                                      AppString.following1123,
                                      AppString.following),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: AppSize.appSize18,
                                  bottom: AppSize.appSize16),
                              child: SizedBox(
                                height: AppSize.appSize32,
                                width: AppSize.appSize290,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        allPostController.toggleFollow();
                                      },
                                      child: Obx(() => Container(
                                            width: AppSize.appSize110,
                                            height: AppSize.appSize32,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSize.appSize6),
                                              color: allPostController
                                                      .isFollow.value
                                                  ? AppColor.cardBackgroundColor
                                                  : AppColor.primaryColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                allPostController.isFollow.value
                                                    ? AppString.following
                                                    : AppString.follow,
                                                style: const TextStyle(
                                                  fontSize: AppSize.appSize14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily:
                                                      AppFont.appFontSemiBold,
                                                  color:
                                                      AppColor.secondaryColor,
                                                ),
                                              ),
                                            ),
                                          )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Share.share(AppString.eleanorPena);
                                      },
                                      child: Container(
                                        width: AppSize.appSize110,
                                        height: AppSize.appSize32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.appSize6),
                                          color: AppColor.cardBackgroundColor,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            AppString.shareProfile,
                                            style: TextStyle(
                                              fontSize: AppSize.appSize14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily:
                                                  AppFont.appFontSemiBold,
                                              color: AppColor.secondaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Fluttertoast.showToast(
                                          msg: AppString.userAdded,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: AppSize.size1,
                                          backgroundColor:
                                              AppColor.cardBackgroundColor,
                                          textColor: AppColor.secondaryColor,
                                          fontSize: AppSize.appSize14,
                                        );
                                      },
                                      child: Container(
                                        width: AppSize.appSize40,
                                        height: AppSize.appSize32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.appSize6),
                                          color: AppColor.cardBackgroundColor,
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            AppIcon.add,
                                            width: AppSize.appSize20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Text(
                              AppString.loremString5,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: AppSize.appSize14,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFont.appFontRegular,
                                color: AppColor.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: AppSize.appSize36, bottom: AppSize.appSize32),
                        child: Row(
                          children: [
                            _customHighlights(
                                AppImage.highlight1, AppString.like),
                            _customHighlights(
                                AppImage.highlight2, AppString.travel),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // TabBar without extra padding
          Container(
            color: AppColor.backgroundColor,
            child: Obx(() => TabBar(
                  onTap: (val) {
                    allPostController.selectedTabIndex.value = val;
                  },
                  controller: allPostController.tabController,
                  dividerColor: AppColor.backgroundColor,
                  labelColor: AppColor.secondaryColor,
                  labelStyle: const TextStyle(
                    color: AppColor.secondaryColor,
                  ),
                  unselectedLabelColor: AppColor.text1Color,
                  indicatorColor: AppColor.secondaryColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: AppSize.appSizePoint7,
                  isScrollable: false,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    Tab(
                      icon: Image.asset(
                        AppIcon.photos,
                        width: AppSize.appSize22,
                        color: allPostController.selectedTabIndex.value == 0
                            ? AppColor.secondaryColor
                            : AppColor.text1Color,
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        AppIcon.editComment,
                        width: AppSize.appSize22,
                        color: allPostController.selectedTabIndex.value == 1
                            ? AppColor.secondaryColor
                            : AppColor.text1Color,
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        AppIcon.reel,
                        width: AppSize.appSize22,
                        color: allPostController.selectedTabIndex.value == 2
                            ? AppColor.secondaryColor
                            : AppColor.text1Color,
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        AppIcon.tag,
                        width: AppSize.appSize22,
                        color: allPostController.selectedTabIndex.value == 3
                            ? AppColor.secondaryColor
                            : AppColor.text1Color,
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: allPostController.tabController,
              children: [
                PostsTabView(),
                const CommentsTabView(),
                ReelsTabView(),
                TagsTabView(),
              ],
            ),
          ),
          SizedBox(
            height: AppSize.appSize20,
          )
        ],
      ),
    );
  }

  _customPostFollowersFollowingCount(String text1, String text2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontSize: AppSize.appSize16,
            fontWeight: FontWeight.w600,
            fontFamily: AppFont.appFontSemiBold,
            color: AppColor.secondaryColor,
          ),
        ),
        Text(
          text2,
          style: const TextStyle(
            fontSize: AppSize.appSize16,
            fontWeight: FontWeight.w400,
            fontFamily: AppFont.appFontRegular,
            color: AppColor.secondaryColor,
          ),
        ),
      ],
    );
  }

  _customHighlights(String image, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSize.appSize16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSize.appSize6),
            child: Image.asset(
              image,
              width: AppSize.appSize52,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: AppSize.appSize12,
              fontWeight: FontWeight.w400,
              fontFamily: AppFont.appFontRegular,
              color: AppColor.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
