import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/homepage%20work/details_page.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';

class NotificationItem extends StatelessWidget {
  final String orgname;
  final String orgLogoUrl;
  final String orgId;
  final bool isFirst;

  const NotificationItem({
    super.key,
    required this.orgname,
    required this.orgLogoUrl,
    required this.orgId,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Organisations')
          .doc(orgId)
          .collection('annonces')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingItem();
        }
        if (snapshot.hasError) {
          return _buildErrorItem();
        }
        final annoncesDocs = snapshot.data!.docs;
        if (annoncesDocs.isEmpty) {
          return _buildNoAnnouncementsItem();
        }
        return ListView.separated(
          shrinkWrap: true,
          itemCount: annoncesDocs.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(color: AppColors.highicons),
          itemBuilder: (context, index) {
            final annonceData = annoncesDocs[index].data() as Map<String, dynamic>;
            final announcement = Announcement(
              organizationName: orgname,
              organizationLogoUrl: orgLogoUrl,
              category: annonceData['category'] ?? 'Category not available',
              annonceTitle: annonceData['annonceTitle'] ?? 'Title not available',
              description: annonceData['description'] ?? 'Description not available',
              quantityNeeded: annonceData['quantityNeeded'] ?? 'Quantity needed not available',
              quantityDonated: annonceData['quantityDonated'] ?? 'Quantity donated not available',
              endDate: annonceData['endDate'] ?? 'End date not available',
              imageUrl: annonceData['imageUrl'] ?? '', // Adjust as per your data structure
              annonceId: annoncesDocs[index].id,
              orgId: orgId,
            );
            return AnnouncementItem(announcement: announcement, isFirst: index == 0);
          },
        );
      },
    );
  }

  Widget _buildLoadingItem() {
    return ListTile(
      tileColor: isFirst ? AppColors.icons : AppColors.clear,
      title: const Text('Loading description...'),
    );
  }

  Widget _buildErrorItem() {
    return ListTile(
      tileColor: isFirst ? AppColors.icons : AppColors.clear,
      title: const Text('Error loading description'),
    );
  }

  Widget _buildNoAnnouncementsItem() {
    return ListTile(
      tileColor: isFirst ? AppColors.icons : AppColors.clear,
      title: const Text('No announcements available'),
    );
  }
}

class AnnouncementItem extends StatefulWidget {
  final Announcement announcement;
  final bool isFirst;

  const AnnouncementItem({super.key, required this.announcement, required this.isFirst});

  @override
  _AnnouncementItemState createState() => _AnnouncementItemState();
}

class _AnnouncementItemState extends State<AnnouncementItem> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isClicked = true;
        });
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsPage(annonce: widget.announcement),
        ));
      },
      child: ListTile(
        tileColor: widget.isFirst ? AppColors.icons : AppColors.clear,
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.announcement.organizationLogoUrl),
            ),
            if (!_isClicked)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.highicons,
                  ),
                ),
              ),
          ],
        ),
        title: Text(widget.announcement.annonceTitle),
        subtitle: Text(widget.announcement.description),
        trailing: IconButton(
          icon: const Icon(Icons.star, color: Colors.yellow),
          onPressed: () {
            _addToFavorites(widget.announcement);
          },
        ),
      ),
    );
  }

Future<void> _addToFavorites(Announcement announcement) async {
  try {
    // Check if the announcement already exists in favorites
    final existingDocs = await FirebaseFirestore.instance
        .collection('Favorites')
        .doc(announcement.orgId)
        .collection('annonces')
        .where('annonceId', isEqualTo: announcement.annonceId)
        .get();

    if (existingDocs.docs.isNotEmpty) {
      print('Announcement already exists in favorites');
      return; // Exit function if announcement already exists
    }

    // If announcement doesn't exist, add it to favorites
    await FirebaseFirestore.instance
        .collection('Favorites')
        .doc(announcement.orgId)
        .collection('annonces')
        .doc(announcement.annonceId) // Use the announcement ID as the document ID
        .set({
      'organizationName': announcement.organizationName,
      'organizationLogoUrl': announcement.organizationLogoUrl,
      'description': announcement.description,
      'timestamp': Timestamp.now(),
    });

    print('Announcement added to favorites successfully');
  } catch (error) {
    print('Error adding announcement to favorites: $error');
  }
}

}

