import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
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
                fontSize: 30,
                fontFamily: 'Nunito',
                color: AppColors.highicons,
                fontWeight: FontWeight.bold),
          ),
          leading: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: BackButton(
              color: AppColors.highicons,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: clothesAnnouncements.length,
          itemBuilder: (context, index) {
            return AnnonceCard(
              announcement: clothesAnnouncements[index],
              onDetailsPressed: () {
                // Handle details button press
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => DetailsPage(
                            annonce: clothesAnnouncements[index],
                          )),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
