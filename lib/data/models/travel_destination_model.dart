class TravelDestinationModel {
  final String name;
  final String location;
  final String rating;
  final String status;

  const TravelDestinationModel({
    required this.name,
    required this.location,
    required this.rating,
    required this.status,
  });

  factory TravelDestinationModel.fromMap(Map<String, dynamic> map) {
    return TravelDestinationModel(
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      rating: map['rating'] ?? '',
      status: map['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'rating': rating,
      'status': status,
    };
  }
}

class TravelPackageModel {
  final String name;
  final String location;
  final String rating;
  final String status;
  final String price;
  final String originalPrice;

  const TravelPackageModel({
    required this.name,
    required this.location,
    required this.rating,
    required this.status,
    required this.price,
    required this.originalPrice,
  });

  factory TravelPackageModel.fromMap(Map<String, dynamic> map) {
    return TravelPackageModel(
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      rating: map['rating'] ?? '',
      status: map['status'] ?? '',
      price: map['price'] ?? '',
      originalPrice: map['originalPrice'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'rating': rating,
      'status': status,
      'price': price,
      'originalPrice': originalPrice,
    };
  }
}

class InfluencerModel {
  final String name;
  final String location;
  final String rating;
  final String status;

  const InfluencerModel({
    required this.name,
    required this.location,
    required this.rating,
    required this.status,
  });

  factory InfluencerModel.fromMap(Map<String, dynamic> map) {
    return InfluencerModel(
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      rating: map['rating'] ?? '',
      status: map['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'rating': rating,
      'status': status,
    };
  }
} 