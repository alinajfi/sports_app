import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';
import 'package:http/http.dart' as http;
import '../../config/app_color.dart';

class EditProfileController extends GetxController {
  TextEditingController nameController =
      TextEditingController(text: AppString.eleanorPena);
  TextEditingController usernameController =
      TextEditingController(text: AppString.eleanorPenaID);
  TextEditingController bioController =
      TextEditingController(text: AppString.loremString6);
  TextEditingController genderController =
      TextEditingController(text: AppString.male);
  TextEditingController dobController =
      TextEditingController(text: AppString.dob);
  TextEditingController mobileNumberController =
      TextEditingController(text: AppString.phoneHint2);

  Rx<DateTime?> selectedDate = DateTime.now().obs;
  RxInt selectedGenderIndex = 0.obs;
  RxString profileImagePath = ''.obs;
  RxBool isLoading = false.obs;

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      final token =
          await DbController.instance.readData<String>(DbConstants.apiToken);

      final response = await http.post(
        Uri.parse("https://mysportsjourney.co.uk/api/edit_profile"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
        body: {
          "name": nameController.text.trim(),
          "nickname":
              usernameController.text.trim(), // or actual nickname field
          "phone": mobileNumberController.text.trim(),
          "bio": bioController.text.trim(),
          "gender": genderController.text.trim(),
          "dob": dobController.text.trim(),
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == 200) {
        Get.snackbar("Success", "Profile updated successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Failed", data['message'] ?? "Failed to update profile",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
    }
  }

  String get selectedGender {
    if (selectedGenderIndex.value >= 0 &&
        selectedGenderIndex.value < genderList.length) {
      return genderList[selectedGenderIndex.value];
    } else {
      return '';
    }
  }

  void selectGender(int index) {
    selectedGenderIndex.value = index;
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

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      String formattedDate =
          DateFormat(AppString.dateFormatString).format(picked);
      dobController.text = formattedDate;
    }
  }

  RxList<String> genderList = [
    AppString.male,
    AppString.female,
  ].obs;
}
