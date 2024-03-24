import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_card.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
import 'package:projectfinal/pages/homepage%20work/details_page.dart';

class FoodCategoryPage extends StatelessWidget {
  final List<Announcement> foodAnnouncements;

  const FoodCategoryPage({super.key, required this.foodAnnouncements});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Category',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 24,
              color: AppColors.highicons,
              fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(
          color: AppColors.highicons,
        ),
      ),
      body: ListView.builder(
        itemCount: foodAnnouncements.length,
        itemBuilder: (context, index) {
          return AnnonceCard(
            announcement: foodAnnouncements[index],
            onDetailsPressed: () {
              // Handle details button press
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const DetailsPage()),
              );
            },
          );
        },
      ),
    );
  }
}
