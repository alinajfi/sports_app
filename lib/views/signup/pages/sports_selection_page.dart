import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/sports_selection_controller.dart';

class SportSelectionScreen extends StatelessWidget {
  const SportSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF121212);
    const cardColor = Color(0xFF1E1E1E);
    const borderColor = Color(0xFF3C3C3C);
    const textColor = Colors.white70;
    const selectedColor = Colors.red;

    return GetBuilder<SportSelectionController>(
        init: SportSelectionController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
                onPressed: () => Get.back(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select your Current Sport',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.sports.length,
                        itemBuilder: (context, index) {
                          final sport = controller.sports[index];
                          final isSelected =
                              controller.selectedSportId.value == sport.id;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: GestureDetector(
                              onTap: () => controller.selectSport(sport.id),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 18),
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: isSelected
                                        ? selectedColor
                                        : borderColor,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.sports,
                                      color: isSelected
                                          ? selectedColor
                                          : textColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      sport.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected
                                            ? selectedColor
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 56,
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: controller.selectedSportId.value != null
                            ? () => controller.submitSelectedSports()
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              controller.selectedSportId.value != null
                                  ? selectedColor
                                  : borderColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Save Sport',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }),
            ),
          );
        });
  }
}
