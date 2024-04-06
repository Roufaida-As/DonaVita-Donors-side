import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:projectfinal/Theme/colors.dart';

// ignore: must_be_immutable
class MyBottomNavBar extends StatefulWidget {
  final ValueChanged<int>? onTabChange;
  const MyBottomNavBar({super.key, required this.onTabChange});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GNav(
        backgroundColor: AppColors.clear,
        color: AppColors.icons,
        activeColor: AppColors.icons,
        tabBackgroundColor: AppColors.highicons,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        tabBorderRadius: 30,
        selectedIndex: _selectedIndex,
        onTabChange: (value) {
          setState(() {
            _selectedIndex = value;
          });
          if (widget.onTabChange != null) {
            widget.onTabChange!(value);
          }
        },
        gap: 8,
        padding: const EdgeInsets.all(16),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: " Home",
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.icons,
            ),
          ),
          GButton(
            icon: Icons.chat,
            text: " Chat",
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.icons,
            ),
          ),
          GButton(
              icon: Icons.notifications_active,
              text: " Notifications",
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.icons,
              )),
          GButton(
            icon: Icons.person,
            text: " Profile",
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.icons,
            ),
          ),
        ]);
  }
}
