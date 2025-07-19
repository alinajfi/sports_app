// ignore_for_file: must_be_immutable
// ignore_for_file: deprecated_member_use
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/highlight_model.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/extensions.dart';
import 'package:prime_social_media_flutter_ui_kit/views/profile/tabs/profile_comments_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/profile/tabs/profile_posts_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/profile/tabs/profile_reels_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/profile/tabs/profile_tags_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/profile/profile_action_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  ProfileController profileController = Get.put(ProfileController());
  late final LanguageController languageController;

  @override
  Widget build(BuildContext context) {
    // Initialize language controller with null check
    try {
      languageController = Get.find<LanguageController>();
    } catch (e) {
      // If controller not found, put a new instance
      languageController = Get.put(LanguageController());
    }

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      title: const Padding(
        padding: EdgeInsets.only(left: AppSize.appSize5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppString.eleanorPenaID,
            style: TextStyle(
              fontSize: AppSize.appSize20,
              fontWeight: FontWeight.w600,
              fontFamily: AppFont.appFontSemiBold,
              color: AppColor.secondaryColor,
            ),
          ),
        ),
      ),
      actions: [
        Obx(() => Padding(
              padding: EdgeInsets.only(
                right: AppSize.appSize10,
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize16
                    : AppSize.appSize0,
              ),
              child: GestureDetector(
                onTap: () {
                  try {
                    profileActionBottomSheet(context);
                  } catch (e) {
                    debugPrint('Error showing bottom sheet: $e');
                  }
                },
                child: Container(
                  width: AppSize.appSize40,
                  color: AppColor.backgroundColor,
                  child: Center(
                    child: Image.asset(
                      AppIcon.info,
                      height: AppSize.appSize14,
                      width: AppSize.appSize3,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(context),
                  //  _buildHighlights(),
                ],
              ),
            ),
          ),
          Container(
            color: AppColor.backgroundColor,
            child: Obx(() => TabBar(
                  onTap: (val) {
                    profileController.selectedTabIndex.value = val;
                  },
                  controller: profileController.tabController,
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
                  tabs: [
                    Tab(
                      icon: Image.asset(
                        AppIcon.photos,
                        width: AppSize.appSize22,
                        color: profileController.selectedTabIndex.value == 0
                            ? AppColor.secondaryColor
                            : AppColor.text1Color,
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        AppIcon.editComment,
                        width: AppSize.appSize22,
                        color: profileController.selectedTabIndex.value == 1
                            ? AppColor.secondaryColor
                            : AppColor.text1Color,
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        AppIcon.reel,
                        width: AppSize.appSize22,
                        color: profileController.selectedTabIndex.value == 2
                            ? AppColor.secondaryColor
                            : AppColor.text1Color,
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                        AppIcon.tag,
                        width: AppSize.appSize22,
                        color: profileController.selectedTabIndex.value == 3
                            ? AppColor.secondaryColor
                            : AppColor.text1Color,
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            child: TabBarView(
              controller: profileController.tabController,
              children: [
                ProfilePostsTabView(),
                const ProfileCommentsTabView(),
                ProfileReelsTabView(),
                ProfileTagsTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.appSize35,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSize.appSize14),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    try {
                      Get.toNamed(AppRoutes.storyWithMessageView);
                    } catch (e) {
                      debugPrint('Navigation error: $e');
                    }
                  },
                  child: Image.asset(
                    AppImage.story2,
                    width: AppSize.appSize82,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: AppSize.appSize50,
                    margin: EdgeInsets.only(
                      left: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize8
                          : AppSize.appSize30,
                      right: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize30
                          : AppSize.appSize0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _customPostFollowersFollowingCount(
                            AppString.followers200k, AppString.supporters),
                        _customPostFollowersFollowingCount(
                            AppString.following1123, AppString.following),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: AppSize.appSize4),
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
          const Text(
            AppString.loremString5,
            style: TextStyle(
              fontSize: AppSize.appSize14,
              fontWeight: FontWeight.w400,
              fontFamily: AppFont.appFontRegular,
              color: AppColor.secondaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize14),
            child: SizedBox(
              height: AppSize.appSize32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      try {
                        Get.toNamed(AppRoutes.supportersScreenRoute);
                      } catch (e) {
                        debugPrint('Navigation error: $e');
                      }
                    },
                    child: Container(
                      width: kIsWeb ? AppSize.appSize355 : AppSize.appSize147,
                      height: AppSize.appSize32,
                      margin: EdgeInsets.only(
                        right: AppSize.appSize8,
                        left: languageController.selectedLanguageIndex.value ==
                                AppSize.size2
                            ? AppSize.appSize8
                            : AppSize.appSize0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.appSize6),
                        color: AppColor.cardBackgroundColor,
                      ),
                      child: const Center(
                        child: Text(
                          AppString.follow,
                          style: TextStyle(
                            fontSize: AppSize.appSize14,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppFont.appFontRegular,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        try {
                          Share.share(AppString.eleanorPena);
                        } catch (e) {
                          debugPrint('Share error: $e');
                        }
                      },
                      child: Container(
                        width: AppSize.appSize147,
                        height: AppSize.appSize32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.appSize6),
                          color: AppColor.cardBackgroundColor,
                        ),
                        child: const Center(
                          child: Text(
                            AppString.message,
                            style: TextStyle(
                              fontSize: AppSize.appSize14,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFont.appFontRegular,
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize14),
            child: SizedBox(
              height: AppSize.appSize32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        try {
                          Get.toNamed(AppRoutes.eventScreenRoute);
                        } catch (e) {
                          debugPrint('Navigation error: $e');
                        }
                      },
                      child: Container(
                        width:
                            kIsWeb ? AppSize.appSize355 : context.screenWidth,
                        height: AppSize.appSize32,
                        margin: EdgeInsets.only(
                          left:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize8
                                  : AppSize.appSize0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.appSize6),
                          color: AppColor.cardBackgroundColor,
                        ),
                        child: Center(
                          child: Text(
                            AppString.upcommingEvent,
                            style: TextStyle(
                              fontSize: AppSize.appSize14,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFont.appFontRegular,
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: AppSize.appSize14),
            child: PremiumSubscriptionCard(),
          )
        ],
      ),
    );
  }

  Widget _buildHighlights() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        top: AppSize.appSize36,
        bottom: AppSize.appSize32,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _customHighlights(AppIcon.add3, AppString.add, () {
                try {
                  final index = profileController.highlights.length + 1;
                  profileController.highlights.add(
                      HighlightItem(AppImage.highlight1, "Highlight $index"));
                } catch (e) {
                  debugPrint('Error adding highlight: $e');
                }
              }),
              _customHighlights(AppImage.highlight1, AppString.like, () {}),
              _customHighlights(AppImage.highlight2, AppString.travel, () {}),
              ...profileController.highlights
                  .map((highlight) =>
                      _customHighlights(highlight.image, highlight.label, () {
                        try {
                          profileController.highlights.remove(highlight);
                        } catch (e) {
                          debugPrint('Error removing highlight: $e');
                        }
                      }))
                  .toList(),
            ],
          )),
    );
  }

  Widget _customPostFollowersFollowingCount(String text1, String text2) {
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

  Widget _customHighlights(String image, String text, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
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
      ),
    );
  }
}

class PremiumSubscriptionCard extends StatelessWidget {
  const PremiumSubscriptionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF4A90E2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon Box
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.diamond_outlined,
                    color: Color(0xFF9E9E9E),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),

                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Premium Subscriptions',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: const [
                          Text(
                            '£2.50',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '/ monthly',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Support Button
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      try {
                        if (Get.isRegistered<GetMaterialController>()) {
                          Get.toNamed(AppRoutes.profileScreenRoute);
                        } else {
                          debugPrint(
                              'GetMaterialApp is not properly initialized.');
                        }
                      } catch (e) {
                        debugPrint('Navigation error: $e');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF8C00),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text(
                        'SUPPORT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// class PremiumSubscriptionCard extends StatelessWidget {
//   const PremiumSubscriptionCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF1E1E1E),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: const Color(0xFF4A90E2),
//           width: 2,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Diamond Icon
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF2A2A2A),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(
//                 Icons.diamond_outlined,
//                 color: Color(0xFF9E9E9E),
//                 size: 30,
//               ),
//             ),
//             const SizedBox(width: 16),

//             // Text Content
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     'Premium Subscriptions',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xFF9E9E9E),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.baseline,
//                     textBaseline: TextBaseline.alphabetic,
//                     children: [
//                       const Text(
//                         '£2.50',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Flexible(
//                         child: Text(
//                           '/ monthly',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Color(0xFF9E9E9E),
//                             fontWeight: FontWeight.w400,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Support Button
//             Flexible(
//               child: GestureDetector(
//                 onTap: () {
//                   try {
//                     Get.toNamed(AppRoutes.profileScreenRoute);
//                   } catch (e) {
//                     debugPrint('Navigation error: $e');
//                   }
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFFF8C00),
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: const Text(
//                     'SUPPORT',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }