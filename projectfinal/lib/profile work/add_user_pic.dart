import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/components/dialog.dart';


class AddPic {
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

  Future<void> addPicForUser(String userId, String logoURL) async {
    try {
      DocumentReference docRef =
          _firestore.collection('users').doc(userId);

      await docRef.update({'pic': logoURL});

      Dialogs.showSnackBar(
          'Success', 'donator pic added successfully for user $userId', false);
    } catch (error) {
      Dialogs.showSnackBar(
          'Error', 'Failed to add donator pic for user $userId: $error', true);
    }
  }
}
