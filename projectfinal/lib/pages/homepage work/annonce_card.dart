import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';

class AnnonceCard extends StatefulWidget {
  final Announcement announcement;
  final VoidCallback? onDetailsPressed;
  const AnnonceCard({
    super.key,
    required this.announcement,
    required this.onDetailsPressed,
  });

  @override
  State<AnnonceCard> createState() => _AnnonceCardState();
}

class _AnnonceCardState extends State<AnnonceCard> {
  double donationProgress = 0.0;

  @override
  void initState() {
    super.initState();
    updateDonationProgress();
  }

  void updateDonationProgress() {
    setState(() {
      donationProgress = double.parse(widget.announcement.quantityDonated) /
          double.parse(widget.announcement.quantityNeeded);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isCompleted =
        double.parse(widget.announcement.quantityDonated) >=
            double.parse(widget.announcement.quantityNeeded);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          width: 378,
          height: 183,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(
                widget.announcement.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 108,
                left: 12,
                //organisation name
                child: Text(
                  widget.announcement.organizationName,
                  style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.icons,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Positioned(
                top: 45,
                left: 12,
                child: SizedBox(
                  width: 65,
                  height: 65,
                  //organisation logo
                  child: ClipOval(
                    child: Image.network(
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                        widget.announcement.organizationLogoUrl),
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
                  child: isCompleted
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.icons,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                              color: AppColors.background,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.icons,
                          ),
                          onPressed: widget.onDetailsPressed,
                          child: const Text(
                            "Details",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                              color: AppColors.background,
                            ),
                          ),
                        ),
                ),
              ),
              Positioned(
                top: 142,
                child: Container(
                  height: 41,
                  width: 378,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: const BoxDecoration(color: Color(0xffFEFFDF)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //annonce title
                      Expanded(
                        child: Text(
                          "${widget.announcement.annonceTitle} ",
                          style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: AppColors.highicons),
                        ),
                      ),

                      Expanded(
                        child: LinearPercentIndicator(
                          width: 140,
                          lineHeight: 11.0,
                          percent: donationProgress,
                          barRadius: const Radius.circular(7),
                          center: Text(
                            '${((double.parse(widget.announcement.quantityDonated) / double.parse(widget.announcement.quantityNeeded)) * 100).toString()}%',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 10.0),
                          ),
                          backgroundColor: AppColors.background,
                          progressColor: AppColors.highicons,
                        ),
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
