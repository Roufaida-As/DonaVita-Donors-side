import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projectfinal/firebase_options.dart';
import 'package:projectfinal/pages/home_screen.dart';
import 'package:projectfinal/pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter framework
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
