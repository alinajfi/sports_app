// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import '../../../../config/app_icon.dart';
import '../../../../config/app_size.dart';
import '../../../config/app_color.dart';
import '../../widget/home/post_view_dailog.dart';

class ProfileTagsTabView extends StatelessWidget {
  ProfileTagsTabView({Key? key}) : super(key: key);

  ProfileController profileController = Get.put(ProfileController());

  void goToTab(BuildContext context, int tabIndex) {
    bottomBarController.changeSelectedIndex(context, tabIndex);
    Get.toNamed(AppRoutes.bottomBarView);
  }

  @override
  Widget build(BuildContext context) {
    return _profileTagsTab();
  }

  _profileTagsTab() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: GridView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        physics: AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppSize.size4,
          crossAxisSpacing: AppSize.appSize1,
          mainAxisSpacing: AppSize.appSize1,
        ),
        itemCount: profileController.postsList.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0 ||
                  index == 3 ||
                  index == 7 ||
                  index == 8 ||
                  index == 9 ||
                  index == 12 ||
                  index == 15 ||
                  index == 16) {
                goToTab(context, 3);
              } else {
                showDialog(
                  context: context,
                  barrierColor: AppColor.backgroundColor
                      .withAlpha(AppSize.appSizePoint7.toInt()),
                  builder: (context) {
                    return PostViewDialog(
                        imageUrl: profileController.postsList[index]);
                  },
                );
              }
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(profileController.postsList[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (index == 0 ||
                    index == 3 ||
                    index == 7 ||
                    index == 8 ||
                    index == 9 ||
                    index == 12 ||
                    index == 15 ||
                    index == 16) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppSize.appSize6,
                      left: AppSize.appSize6,
                    ),
                    child: Image.asset(
                      AppIcon.reelFill,
                      width: AppSize.appSize16,
                    ),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
