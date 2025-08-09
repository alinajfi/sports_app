// components/stories_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/home_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/story_model.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';

import '../../create_story/create_story.dart';
import '../../new_post/reel/create_reel_view.dart';
import '../options/story/story_view.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();

    return GetX<HomeController>(
      builder: (homeController) {
        return homeController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Container(
                width: MediaQuery.sizeOf(context).width,
                height:
                    AppSize.appSize120, // Increased height for better layout
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: AppSize.appSize10),
                  itemCount:
                      homeController.storyList.length + 1, // +1 for "Add Story"
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: languageController.selectedLanguageIndex.value ==
                                AppSize.size2
                            ? AppSize.appSize0
                            : AppSize.appSize8,
                        right: languageController.selectedLanguageIndex.value ==
                                AppSize.size2
                            ? AppSize.appSize8
                            : AppSize.appSize0,
                      ),
                      child: index == 0
                          ? _buildAddStoryItem(context)
                          : _buildStoryItem(
                              homeController.storyList[index - 1],
                              false,
                            ),
                    );
                  },
                ),
              );
      },
    );
  }

  Widget _buildAddStoryItem(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateStory(),
            ));

        HomeController().getStories();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: AppSize.appSize70,
                height: AppSize.appSize70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 2,
                  ),
                  color: AppColor.backgroundColor,
                ),
                child: ClipOval(
                  child: Icon(
                    Icons.person,
                    size: AppSize.appSize40,
                    color: AppColor.secondaryColor,
                  ),
                  // If you have user profile image, replace Icon with:
                  // Image.network(
                  //   userProfileImage,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: AppSize.appSize24,
                  height: AppSize.appSize24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primaryColor,
                    border: Border.all(
                      color: AppColor.backgroundColor,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    size: AppSize.appSize14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.appSize8),
          Text(
            "Your Story",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSize.appSize12,
              fontWeight: FontWeight.w500,
              fontFamily: AppFont.appFontRegular,
              color: AppColor.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryItem(StoryModel story, bool isFirstItem) {
    return GestureDetector(
      onTap: () => Get.to(StoryFullView(
        story: story,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: AppSize.appSize70,
            height: AppSize.appSize70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFE1306C), // Instagram-like gradient
                  Color(0xFFFF5722),
                  Color(0xFFFFD54F),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(3), // Border thickness
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.backgroundColor,
              ),
              padding: const EdgeInsets.all(2),
              child: ClipOval(
                child: Image.network(
                  story.postImages.isNotEmpty ? story.postImages : story.photo,
                  width: AppSize.appSize64,
                  height: AppSize.appSize64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: AppSize.appSize64,
                      height: AppSize.appSize64,
                      color: AppColor.text1Color,
                      child: Icon(
                        Icons.person,
                        size: AppSize.appSize32,
                        color: AppColor.backgroundColor,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: AppSize.appSize8),
          SizedBox(
            width: AppSize.appSize70,
            child: Text(
              story.name ?? story.storyId.toString(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppSize.appSize12,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
