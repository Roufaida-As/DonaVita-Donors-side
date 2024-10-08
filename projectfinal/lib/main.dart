import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:projectfinal/firebase_options.dart';
import 'package:projectfinal/pages/NotificationPage_work/firebase_api.dart';
import 'package:projectfinal/pages/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter framework
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   await FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
