import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectfinal/components/dialog.dart';
import 'package:projectfinal/profile%20work/donator_model.dart';


class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<Donator?> getOrganisationById(String orgId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(orgId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        return Donator(
          userName: data['fullname'],
          userEmail: data['email'],
          userPic: data['pic'],
          phoneNumber: data['phonenumber'],
          userId: documentSnapshot.id,
         
        );
      } else {
        Dialogs.showSnackBar(
            'Error', 'Donator with ID $orgId does not exist.', true);
        return null;
      }
    } catch (error) {
      // Handle error
      Dialogs.showSnackBar(
          'Error', 'Error fetching donator: $error', true);
      return null;
    }
  }

  Future<String?> getCurrentUserId() async {
    User? user = _auth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }
}
