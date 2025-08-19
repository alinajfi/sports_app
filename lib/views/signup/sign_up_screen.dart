import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/sign_up_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/views/signup/pages/complete_user_profile_page.dart';
import 'package:prime_social_media_flutter_ui_kit/views/signup/pages/otp_page.dart';
import 'package:prime_social_media_flutter_ui_kit/views/signup/pages/parent_details_page.dart';
import 'package:prime_social_media_flutter_ui_kit/views/signup/pages/sign_up_page.dart';
import 'package:prime_social_media_flutter_ui_kit/views/signup/pages/social_details_page.dart';
import 'package:prime_social_media_flutter_ui_kit/views/signup/pages/sports_selection_page.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final List<Widget> pages = [
    SignUpView(),
    OtpPage(),
    SportSelectionScreen(),
    SocialDetailsPage(),
    CompleteProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Responsive PageView.builder'),
              centerTitle: true,
            ),
            body: PageView.builder(
              controller: controller.pageController,
              scrollDirection: Axis.horizontal,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                final page = pages[index];
                return page;
              },
            ),
          );
        });
  }
}
