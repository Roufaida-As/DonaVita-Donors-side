import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/Theme/colors.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _selectedCategory = 'Recent';

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.highicons,
            fontFamily: 'Nunito',
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryButton(
                label: 'Recent',
                isSelected: _selectedCategory == 'Recent',
                onSelect: () => _onCategorySelected('Recent'),
              ),
              CategoryButton(
                label: 'Favorite',
                isSelected: _selectedCategory == 'Favorite',
                onSelect: () => _onCategorySelected('Favorite'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _selectedCategory == 'Recent'
                ? const RecentContent()
                : const FavoriteContent(),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  const CategoryButton({super.key, 
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.icons : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.icons,
          ),
        ),
      ),
    );
  }
}

class RecentContent extends StatelessWidget {
  const RecentContent({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Organisations').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        final documents = snapshot.data!.docs;
        return ListView.separated(
          itemCount: documents.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(color: AppColors.highicons),
          itemBuilder: (context, index) {
            final orgName = documents[index]['name'];
            final orgLogoUrl = documents[index]['logoURL'];
            final orgId = documents[index].id;
            return NotificationItem(
              orgName: orgName,
              orgLogoUrl: orgLogoUrl,
              orgId: orgId,
              isFirst: index == 0,
            );
          },
        );
      },
    );
  }
}

class NotificationItem extends StatefulWidget {
  final String orgName;
  final String orgLogoUrl;
  final String orgId;
  final bool isFirst;

  const NotificationItem({super.key, 
    required this.orgName,
    required this.orgLogoUrl,
    required this.orgId,
    required this.isFirst,
  });

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Organisations').doc(widget.orgId).collection('annonces').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildListItem(
            widget.orgName,
            widget.orgLogoUrl,
            'Loading description...',
            widget.isFirst ? AppColors.icons : AppColors.clear,
          );
        }
        if (snapshot.hasError) {
          return _buildListItem(
            widget.orgName,
            widget.orgLogoUrl,
            'Error loading description',
            widget.isFirst ? AppColors.icons : AppColors.clear,
          );
        }
        final descriptionDocs = snapshot.data!.docs;
        if (descriptionDocs.isEmpty) {
          return _buildListItem(
            widget.orgName,
            widget.orgLogoUrl,
            'Description not available',
            widget.isFirst ? AppColors.icons : AppColors.clear,
          );
        }
        final description = descriptionDocs.first['description'];
        return InkWell(
          onTap: () {
            setState(() {
              _isClicked = true;
            });
          },
          child: _buildListItem(
            widget.orgName,
            widget.orgLogoUrl,
            description,
            widget.isFirst ? AppColors.icons : AppColors.clear,
          ),
        );
      },
    );
  }

  Widget _buildListItem(String orgName, String orgLogoUrl, String description, Color backgroundColor) {
    return Container(
      color: _isClicked ? AppColors.clear : backgroundColor,
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(orgLogoUrl),
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
        title: Text(
          orgName,
        ),
        subtitle: Text(
          description,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.star, color: Colors.yellow),
          onPressed: () {
            FirebaseFirestore.instance.collection('Favorites').doc(widget.orgId).set({
              'name': orgName,
              'logoURL': orgLogoUrl,
              'description': description,
              'timestamp': Timestamp.now(), // Add timestamp when adding to favorites
            });
          },
        ),
      ),
    );
  }
}

class FavoriteContent extends StatelessWidget {
  const FavoriteContent({super.key});

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
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        final documents = snapshot.data!.docs;
        return ListView.separated(
          itemCount: documents.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(color: AppColors.highicons),
          itemBuilder: (context, index) {
            final orgName = documents[index]['name'];
            final orgLogoUrl = documents[index]['logoURL'];
            final description = documents[index]['description'];
            final timestamp = documents[index]['timestamp']; // Retrieve timestamp
            final docId = documents[index].id;
            return FavoriteItem(
              orgName: orgName,
              orgLogoUrl: orgLogoUrl,
              description: description,
              timestamp: timestamp, // Pass timestamp
              docId: docId,
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

  const FavoriteItem({super.key, 
    required this.orgName,
    required this.orgLogoUrl,
    required this.description,
    required this.timestamp,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.clear, // Set background color to green
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
              _formatTimestamp(timestamp), // Display formatted timestamp
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.yellow), // Change delete icon color to yellow
          onPressed: () {
            deleteFavorite(docId);
          },
        ),
      ),
    );
  }

  Future<void> deleteFavorite(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('Favorites').doc(docId).delete();
      print('Document deleted successfully');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}
