import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/components/dialog.dart';
import 'package:projectfinal/pages/home_screen.dart';
import 'package:projectfinal/pages/loginwork/login_screen.dart';
import 'package:projectfinal/pages/loginwork/verify_email_page.dart';

class Services {
  static void signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => const LoginPage());
  }

  static void signup(
    String email,
    String password,
    String fullname,
    String phonenumber,
  ) async {
    try {
      Dialogs.showLoadingDialog();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'id': FirebaseAuth.instance.currentUser!.uid,
        'email': email,
        'fullname': fullname,
        'phonenumber': phonenumber,
        'pic': ""
      });
      Get.back();
      Dialogs.showSnackBar('Success', 'signup successfully', false);

      Get.to(() => const VerifyEmail(), transition: Transition.fadeIn);
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'weak-password') {
        Dialogs.showSnackBar(
            'Error', 'The password provided is too weak.', true);
      } else if (e.code == 'email-already-in-use') {
        Dialogs.showSnackBar(
            'Error', 'The account already exists for that email.', true);
      }
    } catch (e) {
      Get.back();
      Dialogs.showSnackBar('Error', 'Something went wrong !', true);
    }
  }

  static void loginn(
    String email,
    String password,
  ) async {
    Dialogs.showLoadingDialog();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.back();
      Dialogs.showSnackBar('Success', 'login successfully', false);
      Get.to(() => const HomeScreen(), transition: Transition.fadeIn);
    } catch (e) {
      Get.back();
      Dialogs.showSnackBar('Error', 'Something went wrong !', true);
    }
  }
}
