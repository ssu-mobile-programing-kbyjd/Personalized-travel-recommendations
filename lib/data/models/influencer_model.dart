class InfluencerModel {
  final String name;
  final String location;
  final String rating;
  final String status;
  final bool hasButton;
  final String category;
  final String? imageUrl;

  InfluencerModel({
    required this.name,
    required this.location,
    required this.rating,
    required this.status,
    required this.hasButton,
    required this.category,
    this.imageUrl,
  });
} 