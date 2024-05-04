import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/Theme/colors.dart';

class FavoriteContent extends StatelessWidget {
  const FavoriteContent({super.key, Key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Favorites').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          print('Error fetching Favorites: ${snapshot.error}');
          return const Center(
            child: Text('Error fetching data'),
          );
        }
        final documents = snapshot.data!.docs;
        return ListView.separated(
          itemCount: documents.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(color: AppColors.highicons),
          itemBuilder: (context, index) {
            final orgId = documents[index].id;
            return AnnoncesList(orgId: orgId);
          },
        );
      },
    );
  }
}

class AnnoncesList extends StatelessWidget {
  final String orgId;

  const AnnoncesList({super.key, required this.orgId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Favorites').doc(orgId).collection('annonces').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          print('Error fetching annonces: ${snapshot.error}');
          return const Center(
            child: Text('Error fetching data'),
          );
        }
        final documents = snapshot.data!.docs;
        print('Annonces count: ${documents.length}');
        return ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: documents.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(color: AppColors.highicons),
          itemBuilder: (context, index) {
            final data = documents[index].data() as Map<String, dynamic>;
            final orgName = data['organizationName'] as String? ?? 'Organization Name Not Available';
            final orgLogoUrl = data['organizationLogoUrl'] as String? ?? 'https://example.com/default_logo.png';
            final description = data['description'] as String? ?? 'Description Not Available';
            final timestamp = data['timestamp'] as Timestamp? ?? Timestamp.now();
            final docId = documents[index].id;
            return FavoriteItem(
              orgName: orgName,
              orgLogoUrl: orgLogoUrl,
              description: description,
              timestamp: timestamp,
              docId: docId,
              orgId: orgId,
            );
          },
        );
      },
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final String orgName;
  final String orgLogoUrl;
  final String description;
  final Timestamp timestamp;
  final String docId;
  final String orgId;

  const FavoriteItem({super.key, 
    required this.orgName,
    required this.orgLogoUrl,
    required this.description,
    required this.timestamp,
    required this.docId,
    required this.orgId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.clear,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(orgLogoUrl),
        ),
        title: Text(orgName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(timestamp),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.yellow),
          onPressed: () {
            deleteFavorite(docId, orgId);
          },
        ),
      ),
    );
  }

  Future<void> deleteFavorite(String docId, String orgId) async {
    try {
      await FirebaseFirestore.instance.collection('Favorites').doc(orgId).collection('annonces').doc(docId).delete();
      print('Document deleted successfully');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }

  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}


