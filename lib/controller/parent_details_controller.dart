// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:prime_social_media_flutter_ui_kit/services/user_service.dart';

import '../model/parent_details_model.dart';

class ParentDetailsController extends GetxController {
  final String userId;
  ParentDetailsController({
    required this.userId,
  });

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final telephoneController = TextEditingController();
  final postalCodeController = TextEditingController();
  final addressController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    emailController.dispose();
    telephoneController.dispose();
    postalCodeController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<void> submitDetails() async {
    final details = ParentDetailsModel(
      userId: int.tryParse(userId) ?? 1, // Replace with actual ID
      email: emailController.text,
      phone: telephoneController.text,
      name: "${firstNameController.text} ${lastNameController.text}",
      postCode: postalCodeController.text,
      dateOfBirth: dobController.text,
      address: addressController.text.isEmpty ? null : addressController.text,
    );

    isLoading.value = true;
    final success = await UserService().storeParentDetails(details);
    isLoading.value = false;

    if (success) {
      Get.snackbar("Success", "Parent details saved successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar("Error", "Failed to save parent details",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
