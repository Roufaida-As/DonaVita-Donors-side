import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/components/button.dart';
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

        // Show success message or navigate to a success screen
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent',
                style: TextStyle(color: AppColors.highicons)),
            backgroundColor: AppColors.icons,
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage()));
      } catch (e) {
        // Show error message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Failed to send reset email. Please try again.',
              style: TextStyle(color: AppColors.highicons),
            ),
            backgroundColor: AppColors.icons,
          ),
        );
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

              Image.asset("assets/Icons/Vector.png"),

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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide:
                              BorderSide(color: AppColors.clear, width: 2)),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.icons,
                      ),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(fontSize: 14),
                      fillColor: AppColors.background,
                      filled: true,
                    ),
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

              Button(onTap: _resetPassword, buttonText: "Submit"),
            ],
          ),
        ),
      ),
    );
  }
}
