import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/user_action_controller.dart';

userActionBottomSheet(BuildContext context) {
  UserActionController userActionController = Get.put(UserActionController());
  return showModalBottomSheet(
    backgroundColor: AppColor.backgroundColor,
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSize.appSize12),
        topRight: Radius.circular(AppSize.appSize12),
      ),
      borderSide: BorderSide.none,
    ),
    constraints: const BoxConstraints(
      maxWidth: kIsWeb ? AppSize.appSize800 : double.infinity,
    ),
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Container(
        height: AppSize.appSize335,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
          top: AppSize.appSize12,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.appSize12),
            topRight: Radius.circular(AppSize.appSize12),
          ),
          color: AppColor.backgroundColor,
        ),
        child: Column(
          children: [
            Container(
              width: AppSize.appSize28,
              height: AppSize.appSize2,
              margin: const EdgeInsets.only(bottom: AppSize.appSize20),
              decoration: BoxDecoration(
                color: AppColor.lineColor,
                borderRadius: BorderRadius.circular(
                  AppSize.appSize6,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: userActionController.userActionsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    userActionController.selectItem(index);
                  },
                  child: Obx(() => Container(
                    height: AppSize.appSize48,
                    margin: const EdgeInsets.only(
                      bottom: AppSize.appSize8, left: AppSize.appSize14, right: AppSize.appSize14,
                    ),
                    decoration: BoxDecoration(
                      color: userActionController.isSelected.value == index ? AppColor.cardBackgroundColor : AppColor.transparentColor,
                      borderRadius: BorderRadius.circular(AppSize.appSize12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppSize.appSize12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userActionController.userActionsList[index],
                          style: const TextStyle(
                            fontSize: AppSize.appSize14,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFont.appFontSemiBold,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  )),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}