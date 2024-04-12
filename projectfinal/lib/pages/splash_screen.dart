import "dart:async";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/verify_email_page.dart';
import 'package:projectfinal/pages/home_screen.dart';
import 'package:projectfinal/pages/login_screen.dart';

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
      if (FirebaseAuth.instance.currentUser != null) {
        if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => const VerifyEmail()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) =>  const HomeScreen()),
          );
        }
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => const LoginPage()),
        );
      }
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
