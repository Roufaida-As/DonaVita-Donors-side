import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:projectfinal/pages/homepage%20work/storage_service.dart';

class AnnouncementService {
  final CollectionReference announcementsCollection =
      FirebaseFirestore.instance.collection('organisationsAsUsers');

  Future<List<Announcement>> getAnnouncements() async {
    QuerySnapshot querySnapshot = await announcementsCollection.get();

    List<Announcement> announcements = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      String orgName = doc['fullname'];
      String orgLogoUrl = doc['logoURL'];
      String organisationId = doc.id;
      String ville = doc['ville'];

      QuerySnapshot orgAnnouncementsSnapshot =
          await doc.reference.collection('annonces').get();

      for (var annDoc in orgAnnouncementsSnapshot.docs) {
        Map<String, dynamic> data = annDoc.data() as Map<String, dynamic>;
        announcements.add(Announcement(
          organizationName: orgName,
          organizationLogoUrl: orgLogoUrl,
          orgId: organisationId,
          annonceId: annDoc.id,
          category: annDoc['category'],
          annonceTitle: annDoc['annonceTitle'],
          description: annDoc['description'],
          quantityNeeded: annDoc['quantityNeeded'],
          endDate: annDoc['endDate'],
          imageUrl: annDoc['ImageUrl'],
          quantityDonated: data.containsKey('quantityDonated')
              ? data['quantityDonated']
              : "not found",
          orgVille: ville,
        ));
      }
    }

    return announcements;
  }
}
