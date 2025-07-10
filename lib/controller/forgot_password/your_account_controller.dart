import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourAccountController extends GetxController {
  TextEditingController emailFieldController = TextEditingController();
  RxBool isButtonTap = false.obs;
  RxString email = "".obs;

  @override
  void dispose() {
    emailFieldController.clear();
    super.dispose();
  }
}