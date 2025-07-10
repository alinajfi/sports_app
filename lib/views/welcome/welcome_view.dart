import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import '../../config/app_string.dart';
import '../../widget/app_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: AppSize.size8,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  AppImage.welcome,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: AppSize.appSize106,
                left: AppSize.appSize16,
                child: Image.asset(
                  AppImage.welcomeString,
                  width: AppSize.appSize230,
                  height: AppSize.appSize220,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: AppSize.size1,
          child: Container(
            padding: const EdgeInsets.only(
              left: AppSize.appSize20,
              right: AppSize.appSize20,
            ),
            child: Center(
              child: AppButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.bottomBarView);
                },
                text: AppString.buttonTextGetStarted,
                backgroundColor: AppColor.primaryColor,
                margin: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
