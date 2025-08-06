// components/stories_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/home_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final languageController = Get.find<LanguageController>();

    return SizedBox(
      height: AppSize.appSize100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: homeController.storyList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: languageController.selectedLanguageIndex.value ==
                      AppSize.size2
                  ? AppSize.appSize0
                  : AppSize.appSize20,
              right: languageController.selectedLanguageIndex.value ==
                      AppSize.size2
                  ? AppSize.appSize20
                  : AppSize.appSize0,
            ),
            child: _buildStoryItem(
              homeController.storyList[index],
              homeController.storyIDList[index],
              index == 0,
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoryItem(String imagePath, String storyId, bool isFirstItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.storyFullView),
          child: Image.asset(
            imagePath,
            width: isFirstItem ? AppSize.appSize64 : AppSize.appSize70,
          ),
        ),
        Text(
          storyId,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: AppSize.appSize14,
            fontWeight: FontWeight.w400,
            fontFamily: AppFont.appFontRegular,
            color: AppColor.secondaryColor,
          ),
        ),
      ],
    );
  }
}
