import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/components/button.dart';
import 'package:projectfinal/pages/loginwork/login_screen.dart';
import 'package:projectfinal/pages/loginwork/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController pwcontroller = TextEditingController();
  final TextEditingController fullnamecontroller = TextEditingController();
  final TextEditingController phonenumbercontroller = TextEditingController();
  final TextEditingController confirmpwcontroller = TextEditingController();
  String selectedWilaya = '1. Adrar'; // Variable to store the selected wilaya
  @override
  Widget build(BuildContext context) {
    void togglePassword() {
      setState(() {
        hidePassword = !hidePassword;
      });
    }

    void toggleConfirmPassword() {
      setState(() {
        hideConfirmPassword = !hideConfirmPassword;
      });
    }

    return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: SingleChildScrollView(
              child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //logo
              const SizedBox(height: 45),

              Image.asset("assets/Icons/logo 2.png",
                  width: 130, height: 102.78),

              const SizedBox(height: 5),
              const Text(
                "Create an Account",
                style: TextStyle(
                  color: AppColors.icons,
                  fontSize: 35,
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
              const SizedBox(height: 13),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                    child: Text('Email',
                        style: TextStyle(
                            color: AppColors.icons,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: TextFormField(
                      controller: emailcontroller,
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
                      keyboardType: TextInputType.emailAddress,
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
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                    child: Text('Full name',
                        style: TextStyle(
                            color: AppColors.icons,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: TextFormField(
                      controller: fullnamecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
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
                          hintText: "Enter your name",
                          hintStyle: const TextStyle(
                              color: AppColors.smalltext, fontSize: 15),
                          prefixIcon: const Icon(
                            Icons.person_2_outlined,
                            color: AppColors.icons,
                          )),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                    child: Text('Phone number',
                        style: TextStyle(
                            color: AppColors.icons,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: TextFormField(
                      controller: phonenumbercontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
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
                          hintText: "Enter your phone number",
                          hintStyle: const TextStyle(
                              color: AppColors.smalltext, fontSize: 15),
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            color: AppColors.icons,
                          )),
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                    child: Text('Password',
                        style: TextStyle(
                            color: AppColors.icons,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: TextFormField(
                      controller: pwcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        return null;
                      },
                      obscureText: hidePassword,
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
                          hintText: "Enter your password",
                          hintStyle: const TextStyle(
                              color: AppColors.smalltext, fontSize: 15),
                          suffixIcon: IconButton(
                              onPressed: () {
                                togglePassword();
                              },
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.icons,
                              )),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: AppColors.icons,
                          )),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                    child: Text('Confirm Password',
                        style: TextStyle(
                            color: AppColors.icons,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: TextFormField(
                      controller: confirmpwcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        if (value != pwcontroller.text.trim()) {
                          return "Wrong password";
                        }
                        return null;
                      },
                      obscureText: hideConfirmPassword,
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
                          hintText: "Enter your password",
                          hintStyle: const TextStyle(
                              color: AppColors.smalltext, fontSize: 15),
                          suffixIcon: IconButton(
                              onPressed: () {
                                toggleConfirmPassword();
                              },
                              icon: Icon(
                                hideConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.icons,
                              )),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: AppColors.icons,
                          )),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              //signup button
              Button(
                buttonText: "Sign up",
                onTap: () => register(),
              ),
              const SizedBox(height: 30),
              // sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: AppColors.smalltext,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Image.asset("assets/Icons/Name.png", width: 64, height: 19),
            ]),
          )),
        ));
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      Services.signup(
        emailcontroller.text.trim(),
        pwcontroller.text.trim(),
        fullnamecontroller.text.trim(),
        phonenumbercontroller.text.trim(),
      );
    }
  }
}
