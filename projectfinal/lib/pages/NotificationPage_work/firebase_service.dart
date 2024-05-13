import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:projectfinal/components/dialog.dart';

class FirebaseService {
  // Function to add token to Firestore
  static Future<void> addTokenToFirestore(String token) async {
    try {
      await FirebaseFirestore.instance.collection('tokens').add({
        'token': token,
      });
      Dialogs.showSnackBar("Success", "Token added successfully", false);
    } catch (error) {
      Dialogs.showSnackBar("Error", "Error adding token: $error", true);
    }
  }

  // Function to retrieve FCM token and add it to Firestore
  static Future<void> getTokenAndAddToFirestore() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await addTokenToFirestore(token);
      } else {
        Dialogs.showSnackBar("Error", "Failed to get token", true);
      }
    } catch (error) {
      Dialogs.showSnackBar("Error", "Error getting token: $error", true);
    }
  }
}
