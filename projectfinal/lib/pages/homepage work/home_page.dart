import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
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
  String selectedWilaya = '1. Adrar'; // Variable to store the selected wilaya
  bool withFilter = false;
  List<Announcement> announcements = [];
  List<Announcement> originalAnnouncements = [];

  @override
  void initState() {
    fetchAnnouncements();
    super.initState();
  }

  Future<void> fetchAnnouncements() async {
    try {
      List<Announcement> fetchedAnnouncements =
          await AnnouncementService().getAnnouncements();
      if (mounted) {
        setState(() {
          announcements = fetchedAnnouncements;
          originalAnnouncements = fetchedAnnouncements;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void filterAnnouncementsByWilaya(String wilaya) {
    setState(() {
      announcements = originalAnnouncements
          .where((announcement) => announcement.orgVille == wilaya)
          .toList();
    });
  }

  void resetFilter() {
    setState(() {
      announcements = originalAnnouncements;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter announcements based on category
    List<Announcement> foodAnnouncements = originalAnnouncements
        .where((announcement) => announcement.category == 'Food')
        .toList();
    List<Announcement> clothesAnnouncements = originalAnnouncements
        .where((announcement) => announcement.category == 'Clothes')
        .toList();
    List<Announcement> moneyAnnouncements = originalAnnouncements
        .where((announcement) => announcement.category == 'money')
        .toList();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Donations",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Nunito',
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
                          backgroundColor: AppColors.highicons,
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
                              fontFamily: 'Nunito',
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
                              fontFamily: 'Nunito',
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
                              fontFamily: 'Nunito',
                              color: AppColors.icons,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.containercolor,
                      ),
                      onPressed: () {
                        setState(() {
                          withFilter = !withFilter;
                          if (!withFilter) {
                            resetFilter(); // Reset filter when switching to without filter mode
                          }
                        });
                      },
                      icon: withFilter
                          ? const Icon(
                              Icons.filter_alt_outlined,
                              color: AppColors.icons,
                            )
                          : const Icon(
                              Icons.filter_alt_off_outlined,
                              color: AppColors.icons,
                            ),
                    ),
                    withFilter
                        ? Expanded(
                            child: DropdownButton<String>(
                              value: selectedWilaya,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedWilaya = newValue!;

                                  filterAnnouncementsByWilaya(selectedWilaya);
                                });
                              },
                              items: _buildWilayasDropdownItems(),
                              hint: const Text("Select your wilaya"),
                              padding: const EdgeInsets.all(12),
                              borderRadius: BorderRadius.circular(12),
                              underline: Container(
                                height: 1,
                                color: AppColors.clear,
                              ),
                              iconEnabledColor: AppColors.icons,
                              style: const TextStyle(
                                color: AppColors.icons,
                                fontSize: 15,
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: announcements.length,
                    itemBuilder: (context, index) {
                      return AnnonceCard(
                        announcement: announcements[index],
                        onDetailsPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DetailsPage(annonce: announcements[index])),
                        ),
                      );
                    },
                  ),
                )
              ])),
        ));
  }

  List<DropdownMenuItem<String>> _buildWilayasDropdownItems() {
    List<String> wilayasList = [
      "1. Adrar",
      "2. Chlef",
      "3. Laghouat",
      "4. Oum El Bouaghi",
      "5. Batna",
      "6. Bejaia",
      "7. Biskra",
      "8. Bechar",
      "9. Blida",
      "10. Bouira",
      "11. Tamanghasset",
      "12. Tebessa",
      "13. Tlemcen",
      "14. Tiaret",
      "15. Tizi Ouzou",
      "16. Algiers",
      "17. Djelfa",
      "18. Jijel",
      "19. Setif",
      "20. Saida",
      "21. Skikda",
      "22. Sidi Bel Abbes",
      "23. Annaba",
      "24. Guelma",
      "25. Constantine",
      "26. Medea",
      "27. Mostaganem",
      "28. M'sila",
      "29. Mascara",
      "30. Ouargla",
      "31. Oran",
      "32. El Bayadh",
      "33. Illizi",
      "34. Bordj Bou Arreridj",
      "35. Boumerdes",
      "36. El Tarf",
      "37. Tindouf",
      "38. Tissemsilt",
      "39. El Oued",
      "40. Khenchela",
      "41. Souk Ahras",
      "42. Tipaza",
      "43. Mila",
      "44. Ain Defla",
      "45. Naama",
      "46. Ain Temouchent",
      "47. Ghardaia",
      "48. Relizane",
      "49. El M'ghair",
      "50. Ouled Djellal",
      "51. Bordj Badji Mokhtar",
      "52. Beni Abbes",
      "53. Timimoun",
      "54. Touggourt",
      "55. Djanet",
      "56. In Salah",
      "57. In Guezzam",
      "58. El Menia",
    ];

    return wilayasList.map((String wilaya) {
      return DropdownMenuItem<String>(
        value: wilaya,
        child: Text(wilaya),
      );
    }).toList();
  }
}
