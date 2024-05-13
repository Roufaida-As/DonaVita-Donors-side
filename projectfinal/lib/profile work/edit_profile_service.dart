import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/components/dialog.dart';

class EditUserInfos {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getCurrentUserId() async {
    User? user = _auth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Future<void> editUserInfos(
      String userId, String name, String phonenumber) async {
    try {
      Dialogs.showLoadingDialog();
      DocumentReference docRef =
          _firestore.collection('users').doc(userId);

      await docRef.update({'fullname': name, 'phonenumber': phonenumber});

      Dialogs.showSnackBar(
          'Success', 'Infos edited successfully for user $userId', false);
    } catch (error) {
      Dialogs.showSnackBar(
          'Error', 'Failed to edit infos for user $userId: $error', true);
    }
  }
}
