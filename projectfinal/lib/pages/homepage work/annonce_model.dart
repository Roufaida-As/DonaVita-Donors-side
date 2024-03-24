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
  });

  // Add any additional methods if needed
}
