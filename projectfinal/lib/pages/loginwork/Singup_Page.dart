// ignore: unnecessary_import
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unnecessary_import
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/components/button.dart';
import 'package:projectfinal/components/textfield.dart';
import 'package:projectfinal/components/registration_controller.dart';
import 'package:projectfinal/pages/loginwork/login_screen.dart';
import 'package:projectfinal/pages/loginwork/verify_email_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController pwcontroller = TextEditingController();
  final TextEditingController fullnamecontroller = TextEditingController();
  final TextEditingController confirmpwcontroller = TextEditingController();
  final RegistrationController registrationController =
      RegistrationController();

  void showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.icons,
        elevation: 4,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: AppColors.clear, width: 2),
        ),
        content: const Center(
          child: Text(
            'SignUp succsfully',
            style: TextStyle(color: AppColors.background),
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

// signUp method
  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try creating the user
    try {
      //cheak if password is confirmed
      if (pwcontroller.text == confirmpwcontroller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: pwcontroller.text,
        );
        addUserInfo(
          fullnamecontroller.text.trim(),
          emailcontroller.text.trim(),
        );
      } else {
        //show error message, passwords don't match
        showErrorMessage("passwords don't match");
      }
      //pop the loading circle
      Navigator.pop(context, true);

      showSuccessMessage(context);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const VerifyEmail()));
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

  Future addUserInfo(String fullname, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'fullname': fullname,
      'email': email,
    });
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.icons,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: AppColors.icons, width: 6),
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
          const Text(
            "Create an Account",
            style: TextStyle(
              color: AppColors.icons,
              fontSize: 38,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
          ),
          //Hi welcome back
          const Text(
            "Hi, enter your details",
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
              const Text('             Email',
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
                  decoration: const InputDecoration(),
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
          //textfield fullname
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('             Full name',
                  style: TextStyle(
                      color: AppColors.icons,
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500)),
              Container(
                alignment: Alignment.centerLeft,
                child: NoteFormField(
                  controller: fullnamecontroller,
                  obscureText: false,
                  hintText: " Enter your full name",
                  decoration: const InputDecoration(),
                  prefixIcon: Icons.person_2_outlined,
                  textInputAction: TextInputAction.next,
                  validator: (fullName) {
                    fullName = fullName?.trim() ?? '';

                    return fullName.isEmpty ? 'No name provided!' : null;
                  },
                  onChanged: (newValue) {
                    registrationController.fullName = newValue;
                  },
                ),
              )
            ],
          ),
          //textfield pw
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('             Password',
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
                  decoration: const InputDecoration(),
                  prefixIcon: Icons.lock_outline,
                  textInputAction: TextInputAction.next,
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
                    return errorMessage.isNotEmpty ? errorMessage.trim() : null;
                  },
                  onChanged: (newValue) {
                    registrationController.password = newValue;
                  },
                ),
              )
            ],
          ),
          //textfield cnf pw
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('             Confirm Password',
                  style: TextStyle(
                      color: AppColors.icons,
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500)),
              Container(
                alignment: Alignment.centerLeft,
                child: NoteFormField(
                  controller: confirmpwcontroller,
                  obscureText: false,
                  hintText: " Confirme your password",
                  decoration: const InputDecoration(),
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
                    return errorMessage.isNotEmpty ? errorMessage.trim() : null;
                  },
                  onChanged: (newValue) {
                    registrationController.cnfpassword = newValue;
                  },
                ),
                /*
                         
                          hintText: " Enter your password",
                          
                         
                        ),*/
              )
            ],
          ),

          const SizedBox(height: 25),

          //signup button
          Button(
            onTap: () => signUserUp(),
            buttonText: "Sign up",
          ),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(
                  color: AppColors.smallfont,
                  fontFamily: 'Nunito',
                  fontSize: 17.26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginPage()));
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(
                    color: AppColors.highicons,
                    fontFamily: 'Nunito',
                    fontSize: 17.26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          Image.asset("assets/Icons/Name.png", width: 64, height: 19),
        ]),
      )),
    );
  }
}
