import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_card.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_service.dart';
import 'package:projectfinal/pages/homepage%20work/clothes_category_page.dart';
import 'package:projectfinal/pages/homepage%20work/details_page.dart';
import 'package:projectfinal/pages/homepage%20work/food_category_page.dart';
import 'package:projectfinal/pages/homepage%20work/money_category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Announcement> announcements = [];

  Future<void> fetchAnnouncements() async {
    try {
      List<Announcement> fetchedAnnouncements =
          await AnnouncementService().getAnnouncements();
      if (mounted) {
        setState(() {
          announcements = fetchedAnnouncements;
        });
      }
    } catch (e) {
      print('Error fetching announcements: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter announcements based on category
    List<Announcement> foodAnnouncements = announcements
        .where((announcement) => announcement.category == 'food')
        .toList();
    List<Announcement> clothesAnnouncements = announcements
        .where((announcement) => announcement.category == 'clothes')
        .toList();
    List<Announcement> moneyAnnouncements = announcements
        .where((announcement) => announcement.category == 'money')
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Donations",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 24,
                color: AppColors.highicons,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //food category
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors
                              .highicons,
                        ),
                        onPressed: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FoodCategoryPage(
                                            foodAnnouncements:
                                                foodAnnouncements)),
                              )
                            },
                        child: const Text(
                          "FOOD",
                          style: TextStyle(
                              color: AppColors.background,
                              fontWeight: FontWeight.bold),
                        )),
                    //clothes category
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.icons,
                        ),
                        onPressed: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ClothesCategoryPage(
                                          clothesAnnouncements:
                                              clothesAnnouncements),
                                ),
                              )
                            },
                        child: const Text(
                          "CLOTHES",
                          style: TextStyle(
                              color: AppColors.background,
                              fontWeight: FontWeight.bold),
                        )),

                    //money category
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.clear,
                        ),
                        onPressed: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MoneyCategoryPage(
                                          moneyAnnouncements:
                                              moneyAnnouncements),
                                ),
                              )
                            },
                        child: const Text(
                          "MONEY",
                          style: TextStyle(
                              color: AppColors.icons,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                Expanded(
                    child: FutureBuilder(
                  future: fetchAnnouncements(),
                  builder: ((context, snapshot) {
                    return ListView.builder(
                      itemCount: announcements.length,
                      itemBuilder: (context, index) {
                        return AnnonceCard(
                            announcement: announcements[index],
                            onDetailsPressed: () => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) =>  DetailsPage(annonce:announcements[index])),
    ));
                      },
                    );
                  }),
                ))
              ])),
        ));
  }



}
