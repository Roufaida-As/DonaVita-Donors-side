import 'package:flutter/material.dart';

class MoneyCtagory extends StatefulWidget {
  const MoneyCtagory({super.key});

  @override
  State<MoneyCtagory> createState() => _MoneyCategoryState();
}

class _MoneyCategoryState extends State<MoneyCtagory> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('money announces...'))
    );
  }
}