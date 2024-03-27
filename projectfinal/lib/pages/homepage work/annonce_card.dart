

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
import 'package:projectfinal/pages/homepage%20work/details_page.dart';

class AnnonceCard extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback? onDetailsPressed;
  const AnnonceCard({
    super.key,
    required this.announcement,
    required this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 378,
          height: 183,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                  announcement.imageUrl), // Load the image from URL
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 105,
                left: 9,
                //organisation name
                child: Text(
                  announcement.organizationName,
                  style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.icons,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Positioned(
                top: 60,
                left: 18,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  //organisation logo
                  child: Image.network(
                    announcement.organizationLogoUrl,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Positioned(
                top: 120,
                right: 8,
                child: SizedBox(
                    height: 20,
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.icons,
                      ),
                      onPressed: onDetailsPressed,
                      child: const Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.background,
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //annonce title
            Text(
              announcement.annonceTitle,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.highicons),
            ),

            LinearPercentIndicator(
              width: 140.0,
              lineHeight: 14.0,
              percent: 0.5,
              barRadius: const Radius.circular(10),
              center: const Text(
                '50%',
                style: TextStyle(fontSize: 12.0),
              ),
              backgroundColor: AppColors.background,
              progressColor: AppColors.highicons,
            ),
          ],
        )
      ],
    );
  }
  
}
