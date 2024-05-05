/*import 'package:flutter/material.dart';
import 'package:projectfinal/pages/loginwork/Singup_screen.dart';
import 'package:projectfinal/pages/loginwork/login_screen.dart';

class LoginOrSignUpPage extends StatefulWidget {
  const LoginOrSignUpPage({super.key});

  @override
  State<LoginOrSignUpPage> createState() => _LoginOrSignUpPageState();
}

class _LoginOrSignUpPageState extends State<LoginOrSignUpPage> {
  // initially show login page
  bool showLoginPage = true;

  //toggle between login page and signup page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return SignUp();
    }
  }
}*/
