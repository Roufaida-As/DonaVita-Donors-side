// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unused_import, unnecessary_import

import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectfinal/Theme/Colors.dart';

class NoteFormField extends StatelessWidget {
  const NoteFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.autoFocus = false,
    required InputDecoration decoration,
    required this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool autoFocus;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 3,
      ),
      child: TextFormField(
        key: key,
        controller: controller,
        obscureText: obscureText,
        autofocus: autoFocus,
        decoration: InputDecoration(
          constraints: BoxConstraints(
            maxHeight: 45,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.icons, width: 2.16),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.icons, width: 2.16),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppColors.icons,
                )
              : null,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.smallfont),
        ),
        validator: validator,
        onChanged: onChanged,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
      ),
    );
  }
}
