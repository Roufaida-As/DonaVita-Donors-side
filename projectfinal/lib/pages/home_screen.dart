import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/chat_page.dart';
import 'package:projectfinal/pages/homepage%20work/home_page.dart';
import 'package:projectfinal/pages/notifications_page.dart';
import 'package:projectfinal/pages/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: AppColors.clear,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  height: 35,
                  width: 60,
                  decoration: BoxDecoration(
                      color: AppColors.highicons,
                      borderRadius: BorderRadius.circular(16),
                      shape: BoxShape.rectangle),
                  child: const Icon(
                    Icons.home_outlined,
                    color: AppColors.icons,
                    size: 27,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Container(
                    height: 35,
                    width: 60,
                    decoration: BoxDecoration(
                        color: AppColors.highicons,
                        borderRadius: BorderRadius.circular(16),
                        shape: BoxShape.rectangle),
                    child: const Icon(
                      Icons.chat_outlined,
                      color: AppColors.icons,
                      size: 27,
                    )),
              ),
              BottomNavigationBarItem(
                icon: Container(
                    height: 35,
                    width: 60,
                    decoration: BoxDecoration(
                        color: AppColors.highicons,
                        borderRadius: BorderRadius.circular(16),
                        shape: BoxShape.rectangle),
                    child: const Icon(
                      Icons.notifications_active_outlined,
                      color: AppColors.icons,
                      size: 27,
                    )),
              ),
              BottomNavigationBarItem(
                icon: Container(
                    height: 35,
                    width: 60,
                    decoration: BoxDecoration(
                        color: AppColors.highicons,
                        borderRadius: BorderRadius.circular(16),
                        shape: BoxShape.rectangle),
                    child: const Icon(
                      Icons.person_2_outlined,
                      color: AppColors.icons,
                      size: 27,
                    )),
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoPageScaffold(child: _buildPage(index));
          }),
    );
  }
}

Widget _buildPage(int index) {
  switch (index) {
    case 0:
      return CupertinoTabView(builder: ((context) {
        return const CupertinoPageScaffold(child: HomePage());
      }));
    case 1:
      return CupertinoTabView(builder: ((context) {
        return  const CupertinoPageScaffold(child: ChatPage());
      }));
    case 2:
      return CupertinoTabView(builder: ((context) {
        return const CupertinoPageScaffold(child: NotificationsPage());
      }));
    case 3:
      return CupertinoTabView(builder: ((context) {
        return const CupertinoPageScaffold(child: ProfilePage());
      }));
    default:
      return const SizedBox(); // Return an empty widget if index is out of bounds
  }
}
