import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';

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
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          width: 378,
          height: 183,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage("assets/Icons/Rectangle 7.png"
                  //announcement.imageUrl (from second app)
                  ), // Load the image from URL
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
                      fontSize: 16,
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
                  child: Image.asset("assets/Icons/Ellipse 8.png"
                      // announcement.organizationLogoUrl,(from second app)
                      ),
                ),
              ),
              const SizedBox(height: 20),
              Positioned(
                top: 115,
                right: 8,
                child: SizedBox(
                    height: 20,
                    width: 90,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.icons,
                      ),
                      onPressed: onDetailsPressed,
                      child: const Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Nunito',
                          color: AppColors.background,
                        ),
                      ),
                    )),
              ),
              Positioned(
                top: 142,
                child: Container(
                  height: 41,
                  width: 378,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: const BoxDecoration(color: Color(0xffFEFFDF)),
                  child: Row(
                    children: [
                      //annonce title

                      Expanded(
                        child: Text(
                          "${announcement.annonceTitle} : ${announcement.description.length <= 30 ? announcement.description : '${announcement.description.substring(0, 25)}...'}",
                          style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: AppColors.highicons),
                        ),
                      ),

                      LinearPercentIndicator(
                        width: 100,
                        lineHeight: 10.0,
                        percent: 0.5,
                        barRadius: const Radius.circular(8),
                        center: const Text(
                          '50%',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10.0),
                        ),
                        backgroundColor: AppColors.background,
                        progressColor: AppColors.highicons,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
