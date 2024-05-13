import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/NotificationPage_work/category_button.dart';
import 'package:projectfinal/pages/NotificationPage_work/favorite_content.dart';
import 'package:projectfinal/pages/NotificationPage_work/recent_content.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  String _selectedCategory = 'Recent';


  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 25,
              color: AppColors.highicons,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryButton(
                label: 'Recent',
                isSelected: _selectedCategory == 'Recent',
                onSelect: () => _onCategorySelected('Recent'),
              ),
              CategoryButton(
                label: 'Favorite',
                isSelected: _selectedCategory == 'Favorite',
                onSelect: () => _onCategorySelected('Favorite'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _selectedCategory == 'Recent'
                ? const RecentContent()
                : const FavoriteContent(),
          ),
        ],
      ),
    );
  }
}