import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/components/button.dart';
import 'package:projectfinal/pages/home_screen.dart';


class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  Timer? timer;
  @override
  void initState() {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 4), (_) async {
      await FirebaseAuth.instance.currentUser!.reload();
      bool result = FirebaseAuth.instance.currentUser!.emailVerified;
      if (result) {
        Get.offAll(() => const HomeScreen(), transition: Transition.fadeIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            
        padding: const EdgeInsets.all(20.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      
            //logo
            Image.asset("assets/Icons/logo 2.png"),
            const SizedBox(
              height: 5,
            ),
            //title

            const Text(
              "Please",
              style: TextStyle(
                color: AppColors.icons,
                fontSize: 35,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Check your email !",
              style: TextStyle(
                color: AppColors.icons,
                fontSize: 35,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 60,
            ),

            //another text for verification

            const Text(
              "We just sent an email to you",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.highicons,
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Click the link in the email to verify your account ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.highicons,
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            //resend button

            Button(
                onTap: () {
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                },
                buttonText: "Resend Email")
          ],
        ),
      )),
    );
  }
}
