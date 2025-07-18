// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';

class SignUpController extends GetxController {
  PageController pageController = PageController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  ///TextEditingController confirmPasswordController = TextEditingController();

  RxBool isButtonTap = false.obs;
  RxBool isPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  RxBool isUsernameValid = false.obs;
  RxBool isShowingUsername = false.obs;
  // RxString isUsername = ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString confirmPass = ''.obs;
  RxString address = ''.obs;
  RxString postalCode = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxBool isDateInvalid = false.obs;
  RxBool isloading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void updateUsernameValidity(String text) {
    // isUsername.value = text;
    isUsernameValid.value = text.length >= 5;
    isShowingUsername.value = false;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      keyboardType: TextInputType.datetime,
      builder: (BuildContext context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.primaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = picked;
      String formattedDate =
          DateFormat(AppString.dateFormatString).format(picked);
      dateOfBirthController.text = formattedDate;
      isDateInvalid.value = false; // Reset error
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    firstNameController.clear();
    lastNameController.clear();
    dateOfBirthController.clear();
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    postalCodeController.clear();
    addressController.clear();
    // confirmPasswordController.clear();
    isUsernameValid.value = false;
    super.dispose();
  }
}
