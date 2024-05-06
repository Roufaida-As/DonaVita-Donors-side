import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // ignore: constant_identifier_names
  static const double IMAGE_HORIZENTAL_PADDING = 24;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> hardCodedSignIn() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: "fz.mansouri@esi-sba.dz",
        password: "updated-password",
      );
      print("================ SignIn success ===============");

      // Handle successful login
    } catch (e) {
      print("Failed to sign in: $e");
    }
  }

  Future<dynamic> updateUserInfo(newName, newEmail, newPhoneNumber) async {
    try {
      await hardCodedSignIn();
      User? currentUser = auth.currentUser;
      await currentUser?.updateDisplayName(newName);
      // ignore: deprecated_member_use
      //await currentUser?.updateEmail(newEmail);
      //await currentUser?.updatePhoneNumber(PhoneAuthCredential());

      print(auth.currentUser);
      print("--------------- updated with success --------------- ");
    } catch (e) {
      print("Failed to update : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(top: 12, left: 12),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.highicons,
              ),
            ),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: IMAGE_HORIZENTAL_PADDING),
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                  child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Image(
                    image: AssetImage("assets/Icons/Rectangle 7.png"),
                    width: 128,
                    height: 128,
                  ),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _nameController,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.icons),
                    ),
                    label: Text(
                      "Name",
                      style: TextStyle(fontSize: 13, color: AppColors.icons),
                    ),
                    focusColor: Colors.amber,
                    fillColor: AppColors.font),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.icons),
                    ),
                    label: Text(
                      "Email",
                      style: TextStyle(fontSize: 13, color: AppColors.icons),
                    ),
                    fillColor: AppColors.font),
              ),
              TextField(
                keyboardType: TextInputType.phone,
                controller: _passwordController,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.icons),
                    ),
                    label: Text(
                      "Phone number",
                      style: TextStyle(fontSize: 13, color: AppColors.icons),
                    ),
                    fillColor: AppColors.font),
              ),
              const SizedBox(
                height: 32,
              ),
              Center(
                  child: TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(AppColors.icons),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () async {
                        //User? currentUser = auth.currentUser;
                        //await currentUser?.sendEmailVerification();
                        await updateUserInfo(_nameController.text,
                            _emailController.text, _passwordController.text);
                      },
                      child: const Text(
                        "Save changes",
                        style: TextStyle(),
                      )))
            ],
          )),
        ));
  }
}
