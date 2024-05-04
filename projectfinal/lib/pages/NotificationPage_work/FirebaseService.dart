import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  // Function to add token to Firestore
  static Future<void> addTokenToFirestore(String token) async {
    try {
      await FirebaseFirestore.instance.collection('tokens').add({
        'token': token,
      });
      print('Token added successfully');
    } catch (error) {
      print('Error adding token: $error');
    }
  }

  // Function to retrieve FCM token and add it to Firestore
  static Future<void> getTokenAndAddToFirestore() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await addTokenToFirestore(token);
      } else {
        print('Failed to get token');
      }
    } catch (error) {
      print('Error getting token: $error');
    }
  }
}