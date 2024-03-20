import 'package:flutter/material.dart';
import 'package:projectfinal/components/bottom_nav_bar.dart';
import 'package:projectfinal/pages/chat_page.dart';
import 'package:projectfinal/pages/homepage%20work/home_page.dart';
import 'package:projectfinal/pages/notifications_page.dart';
import 'package:projectfinal/pages/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // this selected index is to control the bottom nav bar
  int _selectedIndex = 0;

  //this method will update our selected index
  //when the user taps on the bottom bar
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages to display
  final List<Widget> _pages = [
    //home page
    const HomePage(),

    //chat page
    const ChatPage(),

    //notifications page

    const NotificationsPage(),

    //profile page

    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MyBottomNavBar(onTabChange: navigateBottomBar),
      body: _pages[_selectedIndex],
    );
  }
}
