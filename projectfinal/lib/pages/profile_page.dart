import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/pages/edit_profile_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ignore: constant_identifier_names
  static const double IMAGE_HORIZENTAL_PADDING = 24;
  void _goToEditProfilePage() {
    setState(() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const EditProfileScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: _goToEditProfilePage,
                child: const Text('Edit profile',
                    style: TextStyle(
                        fontSize: 17,
                        color: AppColors.icons,
                        fontWeight: FontWeight.bold))),
          ],

        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: IMAGE_HORIZENTAL_PADDING),
              child: Column(
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
                  const Text(
                    "Full Name",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.icons,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextField(
                    enabled: false,
                    readOnly: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.icons),
                        ),
                        label: Text(
                          "Email",
                          style:
                              TextStyle(fontSize: 13, color: AppColors.icons),
                        ),
                        fillColor: AppColors.font),
                  ),
                  const TextField(
                    enabled: false,
                    readOnly: true,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.icons),
                        ),
                        label: Text(
                          "Phone number",
                          style:
                              TextStyle(fontSize: 13, color: AppColors.icons),
                        ),
                        fillColor: AppColors.font),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Log out",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          )
                        ],
                      ))
                ],
              )),
        ));
  }
}