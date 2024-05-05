// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import, use_build_context_synchronously

// ignore: avoid_web_libraries_in_flutter

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/components/button.dart';
import 'package:projectfinal/components/textfield.dart';
import 'package:projectfinal/components/registration_controller.dart';
import 'package:projectfinal/components/item_border.dart';
import 'package:projectfinal/pages/home_screen.dart';
import 'package:projectfinal/pages/loginwork/Singup_Page.dart';
import 'package:projectfinal/pages/loginwork/forgot_password_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectfinal/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  //final void Function()? onTap;
  const LoginPage({
    super.key,
    // required this.onTap
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController pwcontroller = TextEditingController();
  final RegistrationController registrationController =
      RegistrationController();
  GoogleSignIn googleAuth = GoogleSignIn();

  void showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.background,
        elevation: 4,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: AppColors.clear, width: 2),
        ),
        content: Text(
          'Logged in successfully',
          style: TextStyle(color: AppColors.icons),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // login method
  void signUserIn() async {
    //show loading circlex
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: pwcontroller.text,
      );
      //pop the loading circle
      Navigator.pop(context, true);

      showSuccessMessage(context);

      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context, false);
      // show error message
      showErrorMessage(e.code);
/*
      //pop the loading circle
      Navigator.pop(context);*/
    }
  }

  //error msg to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.icons,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(color: AppColors.icons, width: 6),
          ),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: AppColors.background),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //bool isPasswordVisible = true;
    String errorMessage = '';
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //logo
            const SizedBox(height: 104),
            Image.asset("assets/Icons/logo 2.png", width: 130, height: 102.78),
            const SizedBox(height: 10),
            Text(
              "Login",
              style: TextStyle(
                color: AppColors.icons,
                fontSize: 38,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
            //Hi welcome back
            Text(
              "Hi, welcome back !",
              style: TextStyle(
                color: AppColors.highicons,
                fontFamily: 'Nunito',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('             Email',
                    style: TextStyle(
                        color: AppColors.icons,
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500)),
                Container(
                  alignment: Alignment.centerLeft,
                  child: NoteFormField(
                    controller: emailcontroller,
                    obscureText: false,
                    hintText: " Enter your email",
                    decoration: InputDecoration(),
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (email) {
                      email = email?.trim() ?? '';
                      return email.isEmpty
                          ? 'No email provided!'
                          : RegExp(r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])')
                                  .hasMatch(email)
                              ? 'Password is not in a valid format!'
                              : null;
                    },
                    onChanged: (newValue) {
                      registrationController.email = newValue;
                    },
                  ),
                )
              ],
            ),

            //textfield pw
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('             password',
                    style: TextStyle(
                        color: AppColors.icons,
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500)),
                Container(
                  alignment: Alignment.centerLeft,
                  child: NoteFormField(
                    controller: pwcontroller,
                    obscureText: false,
                    hintText: " Enter your password",
                    decoration: InputDecoration(),
                    prefixIcon: Icons.lock_outline,
                    validator: (password) {
                      password = password ?? '';
                      if (password.isEmpty) {
                        errorMessage = 'No password provided!';
                      } else {
                        if (password.length < 6) {
                          errorMessage =
                              'Password must be at least 6 characters long!';
                        }

                        if (!password.contains(RegExp(r'[a-z]'))) {
                          errorMessage =
                              '$errorMessage\nPassowrd must contain at least one lowercase letter';
                        }

                        if (!password.contains(RegExp(r'[A-Z]'))) {
                          errorMessage =
                              '$errorMessage\nPassowrd must contain at least one uppercase letter';
                        }

                        if (!password.contains(RegExp(r'[0-9]'))) {
                          errorMessage =
                              '$errorMessage\nPassowrd must contain at least one number';
                        }
                      }
                      return errorMessage.isNotEmpty
                          ? errorMessage.trim()
                          : null;
                    },
                    onChanged: (newValue) {
                      registrationController.password = newValue;
                    },
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 42),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => forgetPassword(),
                      ));
                    },
                    child: Text(
                      'forgot password?',
                      style: TextStyle(
                          fontSize: 12.95,
                          fontFamily: 'Nunito',
                          color: AppColors.highicons,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            //login button
            Button(
              onTap: signUserIn,
              buttonText: 'Login',
            ),
            const SizedBox(height: 40),
            Text(
              "Or sign in with",
              style: TextStyle(
                color: AppColors.smalltext,
                fontSize: 12.95,
                fontWeight: FontWeight.w600,
                fontFamily: 'Nunito',
              ),
            ),
            const SizedBox(width: 23),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Border_(
                    onTap: () => AuthService.signInWithGoogle(),
                    imagePath: 'assets/Icons/gg.png'),
                const SizedBox(width: 36),
                Border_(onTap: () {}, imagePath: 'assets/Icons/fb.png'),
              ],
            ),
            const SizedBox(height: 33),
            // sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "You don't have an account?",
                  style: TextStyle(
                    color: AppColors.smalltext,
                    fontFamily: 'Nunito',
                    fontSize: 17.26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                /*GestureDetector(
                  onTap: widget.onTap,*/
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const SignUp()));
                  },
                  child: Text(
                    "Sign up now",
                    style: TextStyle(
                      color: AppColors.highicons,
                      fontFamily: 'Nunito',
                      fontSize: 17.26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 58),
            Image.asset("assets/Icons/Name.png", width: 64, height: 19),
          ]),
        ),
      ),
    );
  }
}
