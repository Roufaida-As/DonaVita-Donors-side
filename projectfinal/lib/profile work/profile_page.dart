import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectfinal/Theme/colors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectfinal/components/dialog.dart';
import 'package:projectfinal/pages/loginwork/services.dart';
import 'package:projectfinal/profile%20work/add_user_pic.dart';
import 'package:projectfinal/profile%20work/donator_model.dart';
import 'package:projectfinal/profile%20work/donator_service.dart';
import 'package:projectfinal/profile%20work/edit_profile_page.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Donator? donator;

  Future<void> fetchUserInfos() async {
    FirestoreService firestoreService = FirestoreService();

    String? userId = await firestoreService.getCurrentUserId();
    try {
      if (userId != null) {
        Donator? donator = await firestoreService.getDonatorById(userId);
        if (mounted) {
          setState(() {
            this.donator = donator;
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('debug: $Error fetching donator');
      }
    }
  }

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchUserInfos();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogoHidden = donator?.userPic == "";
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () => Get.to(() => const EditProfile()),
              child: const Text('Edit profile',
                  style: TextStyle(
                      fontSize: 17,
                      color: AppColors.icons,
                      fontWeight: FontWeight.bold))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: _imageFile == null
                    ? Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage("assets/Icons/Ellipse 30.png"),
                            )),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 30,
                                left: 48,
                                child: IconButton(
                                    onPressed: () async {
                                      {
                                        chooseImage(ImageSource.gallery);
                                        await uploadImage(_imageFile!);
                                        addLogoUrl();
                                        setState(() {
                                          isLogoHidden = !isLogoHidden;
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 30,
                                      color: AppColors.background,
                                    ))),
                            const Positioned(
                                top: 75,
                                left: 22,
                                child: Text(
                                  "add a profile picture",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.background,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700),
                                )),
                          ],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              70), // Half of width/height to make it a circle
                          color: Colors
                              .transparent, // Set a transparent background color
                        ),
                        child: ClipOval(
                          child: Image.file(
                            (File(_imageFile?.path ?? "")),

                            width: 140,
                            height: 140,
                            fit: BoxFit.cover, // Cover the entire container
                          ),
                        ),
                      )),
            const SizedBox(
              height: 40,
            ),

            Container(
              margin: const EdgeInsets.all(2),
              width: double.infinity,
              child: const Text(
                "Full Name",
                style: TextStyle(
                    color: AppColors.icons,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),

            //display the name
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: AppColors.icons,
                width: 1,
              ))),
              child: Text(
                donator?.userName ?? "",
                style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.clear),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.only(top: 5),
              width: double.infinity,
              child: const Text(
                "Email",
                style: TextStyle(
                    color: AppColors.icons,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),

            //display the email
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(7),
              padding: const EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: AppColors.icons,
                width: 1,
              ))),
              child: Text(
                donator?.userEmail ?? "",
                style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.clear),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.only(top: 5),
              width: double.infinity,
              child: const Text(
                "Phone number",
                style: TextStyle(
                    color: AppColors.icons,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),

            //display the number
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(7),
              padding: const EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: AppColors.icons,
                width: 1,
              ))),
              child: Text(
                donator?.phoneNumber ?? "",
                style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.clear),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () => Services.signOut(),
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
      ),
    );
  }

  void chooseImage(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<String> uploadImage(XFile file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages =
        referenceRoot.child('donatorsPics/$fileName.jpg');
    Reference referenceImage = referenceDirImages.child(fileName);
    try {
      await referenceImage.putFile(File(file.path));
      String imageUrl = await referenceImage.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return e.toString();
    }
  }

  void addLogoUrl() async {
    AddPic addLogo = AddPic();

    // Get current user ID
    String? userId = await addLogo.getCurrentUserId();
    if (userId != null) {
      // Add or update logo URL for the user
      await addLogo.addPicForUser(userId, await uploadImage(_imageFile!));
    } else {
      Dialogs.showSnackBar('Error', 'No user signed in !', true);
    }
  }
}
