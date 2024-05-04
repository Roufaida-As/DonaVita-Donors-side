// ignore: file_names
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  const CategoryButton({super.key, 
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.icons : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.icons,
          ),
        ),
      ),
    );
  }
}