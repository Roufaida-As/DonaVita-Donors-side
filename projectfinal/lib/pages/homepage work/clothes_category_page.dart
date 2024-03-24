import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_card.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
import 'package:projectfinal/pages/homepage%20work/details_page.dart';

class ClothesCategoryPage extends StatelessWidget {
  final List<Announcement> clothesAnnouncements;

  const ClothesCategoryPage({super.key, required this.clothesAnnouncements});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Clothes Category',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 24,
                color: AppColors.highicons,
                fontWeight: FontWeight.bold),
          ),
          leading: const BackButton(
            color: AppColors.highicons,
          )),
      body: ListView.builder(
        itemCount: clothesAnnouncements.length,
        itemBuilder: (context, index) {
          return AnnonceCard(
            announcement: clothesAnnouncements[index],
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
