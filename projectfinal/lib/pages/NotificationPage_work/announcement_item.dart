// announcement_item.dart
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/homepage%20work/details_page.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';

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
      // Your logic for adding to favorites
    } catch (error) {
      // Error handling
    }
  }
}
