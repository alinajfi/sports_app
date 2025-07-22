import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/user_model.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';

class LoginController extends GetxController {
  TextEditingController loginField1Controller = TextEditingController();
  TextEditingController loginField2Controller = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isButtonTapped = false.obs;
  RxString email = "".obs;
  RxString password = "".obs;

  Future<void> onLoginSuccessFull(UserData user) async {
    DbController.instance
        .writeData<String>(DbConstants.apiToken, user.apiToken);
    Get.offAllNamed(AppRoutes.welcomeView);
  }

  Future<void> onLoginFailed(String errorMessage) async {}

  @override
  void dispose() {
    loginField1Controller.clear();
    loginField2Controller.clear();
    isButtonTapped.value = false;
    super.dispose();
  }
}
