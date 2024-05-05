// ignore: unused_import
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';

class Button extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;

  const Button({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.icons, borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Nunito',
              color: AppColors.background,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
