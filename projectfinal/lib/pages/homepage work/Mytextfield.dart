import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';
class Mytextfield extends StatelessWidget {
  final String abovestring;
  const Mytextfield({super.key,required this.abovestring});

  @override
  Widget build(BuildContext context) {
    return 
     TextField(
            decoration: new InputDecoration(
                
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                    focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
               
                labelText:abovestring,
                labelStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: AppColors.icons
                )
              ),
          );
  }
}