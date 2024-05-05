import "dart:async";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/home_screen.dart';
import 'package:projectfinal/pages/profile_page.dart';
import 'package:projectfinal/pages/verify_email_page.dart';
import 'package:projectfinal/pages/login_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      initialScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/Icons/logo 2.png", width: 130, height: 102.78),
            Image.asset("assets/Icons/Name.png", width: 145, height: 44),
            Image.asset("assets/Icons/Slogan.png", width: 152, height: 19),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

void initialScreen() {
  if (FirebaseAuth.instance.currentUser != null) {
    if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
      Get.to(() => const VerifyEmail(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500));
    } else {
      Get.to(() => const ProfilePage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500));
    }
  } else {
    Get.to(() => const HomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500));
  }
}
