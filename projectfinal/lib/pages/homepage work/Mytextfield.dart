import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
class Mytextfield extends StatelessWidget {
  final String abovestring;
  const Mytextfield({super.key,required this.abovestring});

  @override
  Widget build(BuildContext context) {
    return 
     TextField(
            decoration: InputDecoration(
                
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                    focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
               
                labelText:abovestring,
                labelStyle: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: AppColors.icons
                )
              ),
          );
  }
}