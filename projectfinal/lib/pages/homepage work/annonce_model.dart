class Announcement {
  final String organizationName;
  late final String organizationLogoUrl;
  final String category;
  final String annonceTitle;
  final String description;
  final String quantityNeeded;
  final String quantityDonated;
  final String endDate;
  late final String imageUrl;


  //final String organizationLogoPath;
  //final String announcementImagePath;
  

  Announcement({
    required this.organizationName,
    required this.organizationLogoUrl,
    required this.category,
    required this.annonceTitle,
    required this.description,
    required this.quantityNeeded,
    required this.quantityDonated,
    required this.endDate,
    required this.imageUrl,

   // this.organizationLogoUrl = '', // Initialized as empty string
    //this.imageUrl = '', // Initialized as empty string
    

  });

  // Add any additional methods if needed
}
