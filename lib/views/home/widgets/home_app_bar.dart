// components/home_app_bar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeAppBar({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();

    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      automaticallyImplyLeading: false,
      centerTitle: false,
      scrolledUnderElevation: AppSize.appSize0,
      title: const Padding(
        padding:
            EdgeInsets.only(top: AppSize.appSize12, left: AppSize.appSize6),
        child: Text(
          AppString.appDisplayName,
          style: TextStyle(
            fontSize: AppSize.appSize20,
            fontWeight: FontWeight.w400,
            fontFamily: AppFont.appFontSevillanaRegular,
            color: AppColor.secondaryColor,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            top: AppSize.appSize12,
            right: AppSize.appSize18,
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize13
                    : AppSize.appSize0,
          ),
          child: Row(
            children: [
              _buildActionIcon(
                AppIcon.search,
                () => Get.toNamed(AppRoutes.searchView),
                languageController,
              ),
              _buildActionIcon(
                AppIcon.message,
                () => Get.toNamed(AppRoutes.messagesView),
                languageController,
              ),
              GestureDetector(
                onTap: () => scaffoldKey.currentState?.openEndDrawer(),
                child: const Icon(Icons.list, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionIcon(String iconPath, VoidCallback onTap,
      LanguageController languageController) {
    return Padding(
      padding: EdgeInsets.only(
        left: languageController.selectedLanguageIndex.value == AppSize.size2
            ? AppSize.appSize6
            : AppSize.appSize0,
        right: languageController.selectedLanguageIndex.value == AppSize.size2
            ? AppSize.appSize0
            : AppSize.appSize6,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(iconPath, width: AppSize.appSize32),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
