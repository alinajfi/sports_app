// ignore_for_file: must_be_immutable
// ignore_for_file: deprecated_member_use
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/sign_up_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/highlight_model.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:prime_social_media_flutter_ui_kit/views/profile/tabs/profile_comments_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/profile/tabs/profile_posts_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/profile/tabs/profile_reels_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/profile/tabs/profile_tags_tab_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/signup/pages/parent_details_page.dart';
import 'package:prime_social_media_flutter_ui_kit/views/signup/pages/sports_selection_page.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/profile/profile_action_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileController profileController;
  @override
  void initState() {
    super.initState();
    profileController = Get.put(ProfileController());
  }

  @override
  dispose() {
    super.dispose();
    Get.delete<ProfileController>();
    Get.delete<SignUpController>();
  }

  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    profileController.loadUserProfile();
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(context),
      body: Obx(() => profileController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : _body()),
    );
  }

  _appBar(BuildContext context) {
    final user = profileController.user.value;
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      title: Padding(
        padding: EdgeInsets.only(left: AppSize.appSize5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            user?.nickname ?? "",
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
        Padding(
          padding: EdgeInsets.only(
            right: AppSize.appSize10,
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize16
                    : AppSize.appSize0,
          ),
          child: GestureDetector(
            onTap: () async {
              final RenderBox overlay =
                  Overlay.of(context).context.findRenderObject() as RenderBox;

              await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  100, // X position
                  100, // Y position
                  overlay.size.width - 100,
                  overlay.size.height - 100,
                ),
                items: [
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ParentDetailsPage(),
                            ));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Add Parent Detail"),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SportSelectionScreen(),
                            ));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Add Sport Selection"),
                      ),
                    ),
                  ),
                ],
              );
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
        ),
      ],
    );
  }

  _body() {
    return DefaultTabController(
      length: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(),
                  // _buildHighlights(),
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
                    // Tab(
                    //   icon: Image.asset(
                    //     AppIcon.editComment,
                    //     width: AppSize.appSize22,
                    //     color: profileController.selectedTabIndex.value == 1
                    //         ? AppColor.secondaryColor
                    //         : AppColor.text1Color,
                    //   ),
                    // ),
                    // Tab(
                    //   icon: Image.asset(
                    //     AppIcon.reel,
                    //     width: AppSize.appSize22,
                    //     color: profileController.selectedTabIndex.value == 2
                    //         ? AppColor.secondaryColor
                    //         : AppColor.text1Color,
                    //   ),
                    // ),
                    // Tab(
                    //   icon: Image.asset(
                    //     AppIcon.tag,
                    //     width: AppSize.appSize22,
                    //     color: profileController.selectedTabIndex.value == 3
                    //         ? AppColor.secondaryColor
                    //         : AppColor.text1Color,
                    //   ),
                    // ),
                  ],
                )),
          ),
          Expanded(
            child: TabBarView(
              controller: profileController.tabController,
              children: [
                ProfilePostsTabView(),
                // const ProfileCommentsTabView(),
                // ProfileReelsTabView(),
                // ProfileTagsTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
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
                Obx(() {
                  final user = profileController.user.value;
                  print("Profile photo URL: ${user?.photo}");

                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.storyWithMessageView);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          AppSize.appSize40), // half of 82 for circular
                      child: user?.photo != null && user!.photo.isNotEmpty
                          ? Image.network(
                              user.photo,
                              width: AppSize.appSize82,
                              height: AppSize.appSize82,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                AppImage.story2, // fallback image asset
                                width: AppSize.appSize82,
                                height: AppSize.appSize82,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              AppImage.story2,
                              width: AppSize.appSize82,
                              height: AppSize.appSize82,
                              fit: BoxFit.cover,
                            ),
                    ),
                  );
                }),
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
                            AppString.posts176, AppString.posts),
                        _customPostFollowersFollowingCount(
                            profileController.followersCount.toString(),
                            AppString.followers),
                        _customPostFollowersFollowingCount(
                            profileController.followingCount.toString(),
                            AppString.following),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            final user = profileController.user.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSize.appSize4),
              child: Text(
                user?.name ?? "Guest",
                style: const TextStyle(
                  fontSize: AppSize.appSize16,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFont.appFontSemiBold,
                  color: AppColor.secondaryColor,
                ),
              ),
            );
          }),
          Obx(() {
            final user = profileController.user.value;
            return Text(
              user?.about ?? '',
              style: TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize14),
            child: SizedBox(
              height: AppSize.appSize32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final res = await Get.toNamed(AppRoutes.editProfileView);
                      profileController.loadUserProfile();
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
                          AppString.buttonTextEditProfile,
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
                        Share.share(AppString.eleanorPena);
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
                            AppString.shareProfile,
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
                  GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: AppString.userAdded,
                        backgroundColor: AppColor.cardBackgroundColor,
                        fontSize: AppSize.appSize14,
                        textColor: AppColor.secondaryColor,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    },
                    child: Container(
                      width: AppSize.appSize40,
                      height: AppSize.appSize32,
                      margin: EdgeInsets.only(
                        left: AppSize.appSize8,
                        right: languageController.selectedLanguageIndex.value ==
                                AppSize.size2
                            ? AppSize.appSize8
                            : AppSize.appSize0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.appSize6),
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
        ],
      ),
    );
  }

  // Widget _buildHighlights() {
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

  _customHighlights(String image, String text, Function()? onTap) {
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
