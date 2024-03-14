import "dart:async";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_svg/svg.dart";
import "package:projectfinal/Theme/Colors.dart";
import 'package:flutter_svg/flutter_svg.dart';
import "package:projectfinal/pages/login_screen.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
      ),
    );
   }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0,),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
           Image.asset("assets/Icons/logo 2.png", width: 130, height: 102.78,),
           Image.asset("assets/Icons/Name.png", width: 145,height:44),
           Image.asset("assets/Icons/Slogan.png", width: 152,height:19),
           SizedBox(height: 100,),

            
          ],
        ),
      ),
    );

  }
}