import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // ignore: constant_identifier_names
  static const double IMAGE_HORIZENTAL_PADDING = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            leading:Padding(
                padding: const EdgeInsets.only(top: 12 , left: 12),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0),
                                      side: const BorderSide(
                                          color: AppColors.highicons,
                                          width: 2)))),
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
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
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
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.icons),
                    ),
                    label: Text(
                      "Email",
                      style: TextStyle(fontSize: 13, color: AppColors.icons),
                    ),
                    fillColor: AppColors.font),
              ),
              const TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
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
                      onPressed: () {},
                      child: const Text(
                        "Save changes",
                        style: TextStyle(),
                      )))
            ],
          )),
        ));
  }
}