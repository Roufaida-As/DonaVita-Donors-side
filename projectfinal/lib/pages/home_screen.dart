import 'package:flutter/material.dart';
import 'package:projectfinal/components/bottom_nav_bar.dart';
import 'package:projectfinal/pages/chat_page.dart';
import 'package:projectfinal/pages/home_page.dart';
import 'package:projectfinal/pages/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePgeState();
}

class _HomePgeState extends State<HomeScreen> {
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

    //profile page

    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        bottomNavigationBar: MyBottomNavBar(onTabChange: navigateBottomBar),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
