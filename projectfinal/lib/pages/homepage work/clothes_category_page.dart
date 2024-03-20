
import 'package:flutter/material.dart';

class ClothesCategory extends StatefulWidget {
  const ClothesCategory({super.key});

  @override
  State<ClothesCategory> createState() => _ClothesCategoryState();
}

class _ClothesCategoryState extends State<ClothesCategory> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('clothes announces...')),
    );
  }
}