// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:prime_social_media_flutter_ui_kit/controller/parent_details_controller.dart';

class ParentDetailsPage extends StatelessWidget {
  ParentDetailsPage({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final String userId;

  Widget buildInputField({
    required String label,
    required TextEditingController textController,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[600]!, width: 1),
            ),
            child: TextField(
              controller: textController,
              keyboardType: inputType,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                border: InputBorder.none,
                hintText: 'Enter $label',
                hintStyle: TextStyle(color: Colors.grey[500]),
                suffixIcon: textController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[400]),
                        onPressed: () => textController.clear(),
                      )
                    : null,
              ),
              onChanged: (_) => Get.find<ParentDetailsController>().update(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentDetailsController>(
        init: ParentDetailsController(userId: userId),
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xFF121212),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
                  onPressed: () {}),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Parent Details',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 8),
                  const Text('Step 4 of 5',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 24),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: const LinearGradient(
                            colors: [Colors.red, Colors.pink, Colors.purple],
                            stops: [0.0, 0.5, 1.0])),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      child: GetBuilder<ParentDetailsController>(
                          builder: (controller) {
                        return Column(
                          children: [
                            buildInputField(
                                label: 'First Name',
                                textController: controller.firstNameController),
                            buildInputField(
                                label: 'Last Name',
                                textController: controller.lastNameController),
                            buildInputField(
                                label: 'Date of Birth',
                                textController: controller.dobController),
                            buildInputField(
                                label: 'Email',
                                textController: controller.emailController,
                                inputType: TextInputType.emailAddress),
                            buildInputField(
                                label: 'Telephone',
                                textController: controller.telephoneController,
                                inputType: TextInputType.phone),
                            buildInputField(
                                label: 'Postal Code',
                                textController:
                                    controller.postalCodeController),
                          ],
                        );
                      }),
                    ),
                  ),
                  Obx(() => Container(
                        width: double.infinity,
                        height: 56,
                        margin: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: Get.find<ParentDetailsController>()
                                  .isLoading
                                  .value
                              ? null
                              : Get.find<ParentDetailsController>()
                                  .submitDetails,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28)),
                            elevation: 0,
                          ),
                          child: Get.find<ParentDetailsController>()
                                  .isLoading
                                  .value
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text('Continue',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                        ),
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }
}
