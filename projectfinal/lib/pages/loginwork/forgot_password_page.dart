import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/components/button.dart';
import 'package:projectfinal/components/dialog.dart';
import 'package:projectfinal/pages/loginwork/login_screen.dart';

// ignore: camel_case_types
class forgetPassword extends StatefulWidget {
  const forgetPassword({super.key});

  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

// ignore: camel_case_types
class _forgetPasswordState extends State<forgetPassword> {
  final TextEditingController emailcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailcontroller.text.trim(),
        );
        Dialogs.showSnackBar('Success', 'Password reset email sent', false);
        Get.to(() => const LoginPage());
      } catch (e) {
        Dialogs.showSnackBar(
            'Error', 'Failed to send reset email. Please try again.', true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: BackButton(
            color: AppColors.highicons,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 5),
          child: Column(
            children: [
              //logo
              Image.asset("assets/Icons/logo 2.png"),
              const SizedBox(
                height: 10,
              ),
              //title

              const Text(
                "Forgot  Password ?",
                style: TextStyle(
                  color: AppColors.icons,
                  fontSize: 35,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Image.asset("assets/Icons/exclamation.png"),

              const SizedBox(height: 20),

              const Text(
                "Enter your email and we will send you a link",
                style: TextStyle(
                  color: AppColors.highicons,
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "to reset your password ",
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

              //email
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: emailcontroller,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.icons, width: 2.16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.icons, width: 2.16),
                        ),
                        hintText: "Enter your email",
                        hintStyle: const TextStyle(
                            color: AppColors.smalltext, fontSize: 15),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppColors.icons,
                        )),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value!)) {
                        return 'wrong email format';
                      }
                      if (value.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      value = emailcontroller.text.trim();
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //submit button
              Button(onTap: _resetPassword, buttonText: "Submit")
            ],
          ),
        ),
      ),
    );
  }
}
