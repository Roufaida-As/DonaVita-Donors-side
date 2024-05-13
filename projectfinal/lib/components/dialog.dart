import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectfinal/Theme/colors.dart';


class Dialogs {
  static void showLoadingDialog() {
    Get.defaultDialog(
      title: "Loading",
      titleStyle: const TextStyle(color: AppColors.icons),
      content: const CircularProgressIndicator(
        color: AppColors.icons,
      ),
      backgroundColor: AppColors.clear,
    );
  }

  static void showSnackBar(String title, String message, bool isError) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: isError ? Colors.red : AppColors.clear,
        icon: Icon(isError ? Icons.error : Icons.check),
        colorText: AppColors.icons);
  }
}
