import 'dart:developer';

import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/services/home_services.dart';

import '../model/user_model.dart';

class AuthController extends GetxController {
  String? userName;
  UserModel? currentUser;

  Future<void> getCurrentUser() async {
    log("message");
    final userID = DbController.instance.readData<String?>(DbConstants.userId);
    if (userID != null) {
      try {
        currentUser = await HomeServices().getUserProfileWithId(userId: userID);
        userName = currentUser?.username;
      } catch (e) {
        log("-------------" + e.toString());
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }
}
