// announcement_item.dart
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/homepage%20work/details_page.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AnnouncementItem extends StatefulWidget {
  final Announcement announcement;
  final bool isFirst;

  const AnnouncementItem({super.key, required this.announcement, required this.isFirst});

  @override
  _AnnouncementItemState createState() => _AnnouncementItemState();
}

class _AnnouncementItemState extends State<AnnouncementItem> {
  bool _isClicked = false;
  bool _isStarred = false;
  bool _showFullDescription = false;

  // Define the maximum number of words to display initially
  static const int maxWordsToShow = 7;

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
        tileColor: _isClicked
            ? (widget.isFirst ? AppColors.clear : AppColors.background)
            : (widget.isFirst ? AppColors.clear : AppColors.background),
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
        title: Text(widget.announcement.organizationName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.announcement.annonceTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            // Display limited or full description based on _showFullDescription state
            Text(
              _showFullDescription
                  ? widget.announcement.description
                  : _truncateDescription(widget.announcement.description),
            ),
            // Show "See More" or "Show Less" button based on description length
            if (_isOverMaxWords(widget.announcement.description))
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _showFullDescription = !_showFullDescription;
                    });
                  },
                  child: Text(
                    _showFullDescription ? 'Show Less' : 'See More',
                    style: const TextStyle(
                      fontSize: 12, // Smaller font size
                      color: Colors.grey, // Grey color
                    ),
                  ),
                ),
              ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.star_border, color: _isStarred ? Colors.yellow : null),
          onPressed: () {
            setState(() {
              _isStarred = !_isStarred;
            });
            _addToFavorites(widget.announcement);
          },
        ),
      ),
    );
  }

  // Truncate description to maximum number of words
  String _truncateDescription(String description) {
    List<String> words = description.split(' ');
    if (words.length > maxWordsToShow) {
      return '${words.sublist(0, maxWordsToShow).join(' ')}...';
    } else {
      return description;
    }
  }

  // Check if description exceeds maximum words
  bool _isOverMaxWords(String description) {
    List<String> words = description.split(' ');
    return words.length > maxWordsToShow;
  }

  Future<void> _addToFavorites(Announcement announcement) async {
    try {
      // Generate a unique document ID for each announcement in the Favorites collection
      final docRef = FirebaseFirestore.instance.collection('Favorites').doc();

      // Set announcement data with the generated document ID
      await docRef.set({
        'announcementId': docRef.id, // Unique ID for the announcement
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


