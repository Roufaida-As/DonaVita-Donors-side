import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:projectfinal/Theme/Colors.dart";
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           SvgPicture.asset('assets/Icons/logo2.svg', width: 130, height:102.78),
          ],

        ),
      ),
    );

  }
}