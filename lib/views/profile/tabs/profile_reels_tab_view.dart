// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import '../../../../config/app_size.dart';

class ProfileReelsTabView extends StatelessWidget {
  ProfileReelsTabView({Key? key}) : super(key: key);

  ProfileController profileController = Get.put(ProfileController());

  void goToTab(BuildContext context, int tabIndex) {
    bottomBarController.changeSelectedIndex(context, tabIndex);
    Get.toNamed(AppRoutes.bottomBarView);
  }

  @override
  Widget build(BuildContext context) {
    return _profileReelsTab();
  }

  _profileReelsTab() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.appSize20, right: AppSize.appSize20,
      ),
      child: GridView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        physics: AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppSize.size4,
          mainAxisExtent: kIsWeb ? AppSize.appSize250 : AppSize.appSize157,
          crossAxisSpacing: AppSize.appSize1,
          mainAxisSpacing: AppSize.appSize1,
        ),
        itemCount: profileController.reelsList.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              goToTab(context, 3);
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(profileController.reelsList[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.appSize6, left: AppSize.appSize6,
                  ),
                  child: Image.asset(
                    AppIcon.reelFill,
                    width: AppSize.appSize16,
                  ),
                ),
                Positioned(
                  bottom: AppSize.appSize1,
                  left: AppSize.appSize2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppIcon.play,
                        width: AppSize.appSize14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSize.appSize3),
                        child: Text(
                          profileController.reelsViewList[index],
                          style: const TextStyle(
                            fontSize: AppSize.appSize12,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFont.appFontSemiBold,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
