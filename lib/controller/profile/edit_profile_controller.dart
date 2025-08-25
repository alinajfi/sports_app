import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';
import 'package:http/http.dart' as http;
import 'package:prime_social_media_flutter_ui_kit/model/edit_profile_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/user_model.dart';
import 'package:prime_social_media_flutter_ui_kit/services/home_services.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/widget_helper.dart';
import '../../config/app_color.dart';

class EditProfileController extends GetxController {
  // Existing controllers with default values
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

  // New controllers for email and location
  TextEditingController emailController =
      TextEditingController(text: "eleanor.pena@example.com"); // Default email
  TextEditingController locationController =
      TextEditingController(text: "New York, USA"); // Default location

  Rx<DateTime?> selectedDate = DateTime.now().obs;
  RxInt selectedGenderIndex = 0.obs;
  //RxString profileImagePath = ''.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);
  File? profileImage;
  RxBool isLoading = false.obs;

  Future<void> uploadProfilePicture() async {
    if (profileImage == null) {
      Get.snackbar('Error', 'Please select an image first',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final result = await HomeServices()
          .uploadProfilePicture(profileImagePath: profileImage!.path);
      if (result) {
        WidgetHelper.showSnackBar(title: "Success", description: "");
        return;
      }
      WidgetHelper.showSnackBar(title: "Failed", description: "");
    } catch (e) {
      Get.snackbar('Error', 'Error uploading image: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    isLoading.value = true;

    if (!_validateForm()) {
      isLoading.value = false;
      return;
    }

    final userInfo = EditProfileModel(
      name: nameController.text.trim(),
      nickname: usernameController.text.trim(),
      phone: mobileNumberController.text.trim(),
      bio: bioController.text.trim(),
      gender: genderController.text.trim(),
      dob: dobController.text.trim(),

      email: emailController.text.trim(),
      location: locationController.text.trim(),

      username: usernameController.text.trim(), // For the username field
      mobileNumber: mobileNumberController.text.trim(), // Alternativ
    );

    try {
      final result = await HomeServices().updateProfile(userInfo: userInfo);
      if (result) {
        Get.back(result: true);
        return;
      }
      WidgetHelper.showSnackBar(
          title: "Failed", description: "Info update Failed");
    } catch (e) {
      WidgetHelper.showSnackBar(
          title: "Failed", description: "Info update Failed $e");
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateForm() {
    // Validate username (required)
    if (usernameController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Username is required',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    }

    // Validate email (required and format)
    if (emailController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Email is required',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar('Validation Error', 'Please enter a valid email address',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    }

    // Validate phone number (optional, but format check if provided)
    if (mobileNumberController.text.trim().isNotEmpty) {
      String phone = mobileNumberController.text.trim();
      // Remove spaces and special characters for validation
      String cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
      if (cleanPhone.length < 10) {
        Get.snackbar('Validation Error', 'Please enter a valid phone number',
            backgroundColor: Colors.orange, colorText: Colors.white);
        return false;
      }
    }

    // Location is optional, no validation needed

    return true;
  }

  Future<void> updateProfileImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        // You can add image upload logic here if needed
        Get.snackbar("Success", "Profile image selected",
            backgroundColor: Colors.green, colorText: Colors.white);
        update(['image']);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to select image: ${e.toString()}",
          backgroundColor: Colors.red, colorText: Colors.white);
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
    genderController.text = genderList[index];
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1900), // Allow older birth dates
      lastDate: DateTime.now(), // Don't allow future dates for DOB
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

  // Method to load user data from API or local storage
  // Future<void> loadUserData() async {
  //   try {
  //     isLoading.value = true;

  //     final token =
  //         await DbController.instance.readData<String>(DbConstants.apiToken);

  //     // You can add API call to fetch current user data
  //     // final response = await http.get(
  //     //   Uri.parse("https://mysportsjourney.co.uk/api/user_profile"),
  //     //   headers: {
  //     //     "Authorization": "Bearer $token",
  //     //     "Accept": "application/json",
  //     //   },
  //     // );

  //     // For now, keeping the default values set in controllers
  //   } catch (e) {
  //     print("Error loading user data: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> loadUserData() async {
    try {
      isLoading.value = true;
      final token =
          await DbController.instance.readData<String>(DbConstants.apiToken);

      final response = await http.get(
        Uri.parse("https://mysportsjourney.co.uk/api/profile"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        user.value = UserModel.fromJson(jsonData);

        // Set the values in controllers
        nameController.text = user.value?.name ?? '';
        usernameController.text = user.value?.nickname ?? '';
        emailController.text = user.value?.email ?? '';

        mobileNumberController.text = user.value?.phone ?? '';
        genderController.text = user.value?.gender ?? '';

        bioController.text = user.value?.about ?? '';

        print("Profile loaded: ${user.value?.username}");
      } else {
        throw Exception("Failed to load user profile");
      }
    } catch (e) {
      print("Profile error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Load user data when controller initializes
    loadUserData();
  }

  @override
  void onClose() {
    // Dispose all controllers to prevent memory leaks
    nameController.dispose();
    usernameController.dispose();
    bioController.dispose();
    genderController.dispose();
    dobController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.onClose();
  }

  RxList<String> genderList = [
    AppString.male,
    AppString.female,
  ].obs;
}
