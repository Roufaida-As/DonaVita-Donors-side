// ignore: file_names
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:projectfinal/Theme/Colors.dart';

class Border_ extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const Border_({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        /*decoration: BoxDecoration(
            //border: Border.all(color: AppColors.smalltext),
            // borderRadius: BorderRadius.circular(10),
            ),*/
        child: Image.asset(
          imagePath,
          height: 53,
          // width: 91,
        ),
      ),
    );
  }

  static all({required Color color}) {}
}
