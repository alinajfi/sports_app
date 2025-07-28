// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/splash_controller.dart';

import '../../constants/db_constants.dart';
import '../../controller/db_controller.dart';
import '../../routes/app_routes.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserLoggedIn();
  }

  void checkUserLoggedIn() async {
    await Future.delayed(Duration(seconds: 3));
    if (DbController.instance.readData<bool>(DbConstants.isUserLoggedIn) !=
            null &&
        DbController.instance.readData<bool>(DbConstants.isUserLoggedIn)!) {
      Get.offAllNamed(AppRoutes.bottomBarView);
    } else {
      Get.offAllNamed(AppRoutes.loginView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSize.appSize24),
            child: Image.asset(
              AppImage.appLogo,
              width: 200,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          const Text(
            AppString.appDisplayName,
            style: TextStyle(
              fontSize: AppSize.appSize28,
              fontWeight: FontWeight.w400,
              fontFamily: AppFont.appFontSevillanaRegular,
              color: AppColor.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
