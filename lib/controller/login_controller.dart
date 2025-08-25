import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/auth_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/login_response_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/user_model.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:prime_social_media_flutter_ui_kit/services/auth_service.dart';

import '../utils/widget_helper.dart';

class LoginController extends GetxController {
  TextEditingController loginField1Controller = TextEditingController();
  TextEditingController loginField2Controller = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isButtonTapped = false.obs;
  RxString email = "".obs;
  RxString password = "".obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);

  Future<void> onLoginSuccessFull(LoginResponse loginRes) async {
    isLoading.value = false;
    // NotificationService().showLocalNotification(
    //     id: DateTime.now().microsecondsSinceEpoch,
    //     body: "dsfasdfaf",
    //     title: "sdfasjflkad");

    DbController.instance.writeData<String>(
      DbConstants.apiToken,
      loginRes.token,
    );
    DbController.instance.writeData<bool>(
      DbConstants.isUserLoggedIn,
      true,
    );
    DbController.instance.writeData<String>(
      DbConstants.userId,
      loginRes.userId.toString(),
    );

    Get.put(AuthController(), permanent: true);

    Get.offAllNamed(AppRoutes.welcomeView);
  }

  Future<void> onGoogleLoginSuccessfull(
      {required String token, required String userId}) async {
    isLoading.value = false;
    // NotificationService().showLocalNotification(
    //     id: DateTime.now().microsecondsSinceEpoch,
    //     body: "dsfasdfaf",
    //     title: "sdfasjflkad");

    DbController.instance.writeData<String>(
      DbConstants.apiToken,
      token,
    );
    DbController.instance.writeData<bool>(
      DbConstants.isUserLoggedIn,
      true,
    );
    DbController.instance.writeData<String>(DbConstants.userId, userId);
    Get.put(AuthController(), permanent: true);

    Get.offAllNamed(AppRoutes.welcomeView);
  }

  Future<void> onLoginFailed(String errorMessage) async {
    isLoading.value = false;
    WidgetHelper.showSnackBar(title: errorMessage, description: errorMessage);
  }

  // @override
  // void () {
  //   loginField1Controller.clear();
  //   loginField2Controller.clear();
  //   isButtonTapped.value = false;
  //   super.dispose();
  // }
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    loginField1Controller.dispose();
    loginField2Controller.dispose();
    super.onClose();
  }

  // Future<UserModel> fetchUserProfile() async {
  //   final token =
  //       await DbController.instance.readData<String>(DbConstants.apiToken);

  //   final response = await http.get(
  //     Uri.parse("https://mysportsjourney.co.uk/api/profile"),
  //     headers: {
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     return UserModel.fromJson(jsonData);
  //   } else {
  //     throw Exception("Failed to load user profile");
  //   }
  // }

  // Future<void> loadUserProfile() async {
  //   try {
  //     isLoading.value = true;
  //     final profile = await fetchUserProfile();

  //     user.value = profile;
  //     print("Loaded user: ${profile.username}");
  //   } catch (e) {
  //     print("Error loading profile: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
