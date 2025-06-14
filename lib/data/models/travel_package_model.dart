class TravelPackageModel {
  final String name;
  final String location;
  final String rating;
  final String status;
  final String duration;
  final String originalPrice;
  final String price;
  final String category;

  const TravelPackageModel({
    required this.name,
    required this.location,
    required this.rating,
    required this.status,
    required this.duration,
    required this.originalPrice,
    required this.price,
    required this.category,
  });

  factory TravelPackageModel.fromMap(Map<String, dynamic> map) {
    return TravelPackageModel(
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      rating: map['rating'] ?? '',
      status: map['status'] ?? '',
      duration: map['duration'] ?? '',
      originalPrice: map['originalPrice'] ?? '',
      price: map['price'] ?? '',
      category: map['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'rating': rating,
      'status': status,
      'duration': duration,
      'originalPrice': originalPrice,
      'price': price,
      'category': category,
    };
  }
} 