import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetHelper {
  static void showSnackBar(
      {String? title, String? description, Color? bgColor}) {
    Get.snackbar(
      backgroundColor: bgColor ?? Colors.white,
      title ?? "title",
      description ?? 'This is the snackbar message',
      snackPosition: SnackPosition.TOP, // or SnackPosition.TOP
      duration: Duration(seconds: 3),
    );
  }
}
