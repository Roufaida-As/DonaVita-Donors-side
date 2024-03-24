import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_card.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
import 'package:projectfinal/pages/homepage%20work/details_page.dart';

class MoneyCategoryPage extends StatelessWidget {
  final List<Announcement> moneyAnnouncements;

  const MoneyCategoryPage({super.key, required this.moneyAnnouncements});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Money Category',
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
        itemCount: moneyAnnouncements.length,
        itemBuilder: (context, index) {
          return AnnonceCard(
            announcement: moneyAnnouncements[index],
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
