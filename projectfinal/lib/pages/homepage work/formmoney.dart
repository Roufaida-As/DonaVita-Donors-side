import 'package:flutter/material.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
class FormmoneyPage extends StatefulWidget {
  final Announcement annonce;
  const FormmoneyPage({super.key, required this.annonce});

  @override
  State<FormmoneyPage> createState() => _FormmoneyPageState();
}

class _FormmoneyPageState extends State<FormmoneyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:Text("money"),
    );
  }
}