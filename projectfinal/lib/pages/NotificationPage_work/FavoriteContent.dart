import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/Theme/colors.dart';

class FavoriteContent extends StatelessWidget {
  const FavoriteContent({super.key, });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Favorites').orderBy('timestamp', descending: true).snapshots(),
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
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: documents.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(color: AppColors.highicons),
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
      stream: FirebaseFirestore.instance.collection('Favorites').doc(orgId).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final orgName = data['organizationName'] as String? ?? 'Organization Name Not Available';
        final orgLogoUrl = data['organizationLogoUrl'] as String? ?? 'https://example.com/default_logo.png';
        final description = data['description'] as String? ?? 'Description Not Available';
        final timestamp = data['timestamp'] as Timestamp? ?? Timestamp.now();
        final docId = snapshot.data!.id;

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
  }
}

class FavoriteItem extends StatefulWidget {
  final String orgName;
  final String orgLogoUrl;
  final String description;
  final Timestamp timestamp;
  final String docId;
  final String orgId;

  const FavoriteItem({
    Key? key,
    required this.orgName,
    required this.orgLogoUrl,
    required this.description,
    required this.timestamp,
    required this.docId,
    required this.orgId,
  }) : super(key: key);

  @override
  _FavoriteItemState createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  bool _showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.orgLogoUrl),
        ),
        title: Text(widget.orgName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _showFullDescription
                  ? widget.description
                  : _truncateDescription(widget.description),
            ),
            if (_isOverMaxWords(widget.description))
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _showFullDescription = !_showFullDescription;
                    });
                  },
                  child: Text(
                    _showFullDescription ? 'Show Less' : 'Show More',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(widget.timestamp),
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
            deleteFavorite(widget.orgId);
          },
        ),
      ),
    );
  }

  String _truncateDescription(String description) {
    const int maxWordsToShow = 7;
    final List<String> words = description.split(' ');
    if (words.length > maxWordsToShow) {
      return '${words.sublist(0, maxWordsToShow).join(' ')}...';
    } else {
      return description;
    }
  }

  bool _isOverMaxWords(String description) {
    const int maxWordsToShow = 7;
    final List<String> words = description.split(' ');
    return words.length > maxWordsToShow;
  }

  String _formatTimestamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  Future<void> deleteFavorite(String orgId) async {
    try {
      await FirebaseFirestore.instance.collection('Favorites').doc(orgId).delete();
      print('Document deleted successfully');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }
}
