import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:projectfinal/main.dart';
class FirebaseApi{
  //cretae instance of firebase meassaging
  final _firebaseMessaging=FirebaseMessaging.instance;
  //function to initialize notifications

  Future<void> initNotification() async{
    await _firebaseMessaging.requestPermission();

    //fetch thfcmtoken for this device
    final fCMtoken= await _firebaseMessaging.getToken();
    print('Token:$fCMtoken');

    handleMessage();
  }
 
 //function to handle recieved messages
 void handleMessage(){
      /*if message null
      if(message==null) return;*/
      //navigate to new screen
      navigatorKey.currentState?.pushNamed(
        'Notification_screen'
      );
 }

}