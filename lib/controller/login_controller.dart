import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController loginField1Controller = TextEditingController();
  TextEditingController loginField2Controller = TextEditingController();

  RxBool isButtonTapped = false.obs;
  RxString email = "".obs;
  RxString password = "".obs;

  @override
  void dispose() {
    loginField1Controller.clear();
    loginField2Controller.clear();
    isButtonTapped.value = false;
    super.dispose();
  }
}