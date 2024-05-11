import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/NotificationPage_work/announcement_item.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';

class RecentContent extends StatelessWidget {
  const RecentContent({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('organisationsAsUsers').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> orgSnapshot) {
        if (orgSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (orgSnapshot.hasError) {
          return Center(
            child: Text('Error: ${orgSnapshot.error}'),
          );
        }

        final orgDocs = orgSnapshot.data!.docs;
        return ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) => const Divider(color: AppColors.highicons),
          itemCount: orgDocs.length,
          itemBuilder: (context, orgIndex) {
            final orgData = orgDocs[orgIndex].data() as Map<String, dynamic>;
            final orgId = orgDocs[orgIndex].id;

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('organisationsAsUsers').doc(orgId).collection('annonces').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> annoncesSnapshot) {
                if (annoncesSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (annoncesSnapshot.hasError) {
                  return Text('Error: ${annoncesSnapshot.error}');
                }

                final annoncesDocs = annoncesSnapshot.data!.docs;
                return ListView.separated(
                   scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) => const Divider(color: AppColors.highicons),
                  itemCount: annoncesDocs.length,
                  itemBuilder: (context, index) {
                    final annonceData = annoncesDocs[index].data() as Map<String, dynamic>;
                    final category = annonceData['category'] ?? 'Category not available';
                    final annonceTitle = annonceData['annonceTitle'] ?? 'Title not available';
                    final description = annonceData['description'] ?? 'Description not available';
                    final quantityNeeded = annonceData['quantityNeeded'] ?? 'Quantity needed not available';
                    final quantityDonated = annonceData['quantityDonated'] ?? 'Quantity donated not available';
                    final endDate = annonceData['endDate'] ?? 'End date not available';
                    final imageUrl = annonceData['ImageUrl'] ?? '';
                    final annonceId = annoncesDocs[index].id;

                    final orgName = orgData['fullname'] ?? 'not available';
                    final orgLogoUrl = orgData['logoURL'] ?? '';

                    final announcement = Announcement(
                      organizationName: orgName,
                      organizationLogoUrl: orgLogoUrl,
                      category: category,
                      annonceTitle: annonceTitle,
                      description: description,
                      quantityNeeded: quantityNeeded,
                      quantityDonated: quantityDonated,
                      endDate: endDate,
                      imageUrl: imageUrl,
                      annonceId: annonceId,
                      orgId: orgId,
                    );
                    return AnnouncementItem(announcement: announcement, isFirst: orgIndex == 0 && index == 0);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}


