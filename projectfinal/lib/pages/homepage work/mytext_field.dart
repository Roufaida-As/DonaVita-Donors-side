import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';

class Mytextfield extends StatelessWidget {
  final String abovestring;
  final TextEditingController controller;
  const Mytextfield(
      {super.key, required this.abovestring, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.teal)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.teal)),
          labelText: abovestring,
          labelStyle: const TextStyle(
              fontFamily: 'Roboto', fontSize: 14, color: AppColors.icons)),
    );
  }
}
