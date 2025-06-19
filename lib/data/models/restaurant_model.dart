class Restaurant {
  final String name;
  final String address;
  final String description;
  final String image;
  final String? latitude;
  final String? longitude;

  Restaurant({
    required this.name,
    required this.address,
    required this.description,
    required this.image,
    this.latitude,
    this.longitude,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      name: map['name'] as String,
      address: map['address'] as String,
      description: map['description'] as String,
      latitude: map['latitude']?.toString(),
      longitude: map['longitude']?.toString(),
      image: map['image'] as String,
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'image': image,
      if (latitude != null) 'latitude': latitude!,
      if (longitude != null) 'longitude': longitude!,
    };
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? 'assets/images/thumb-1.png',
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'image': image,
      if (latitude != null) 'latitude': latitude!,
      if (longitude != null) 'longitude': longitude!,
    };
  }

  Restaurant copyWith({
    String? name,
    String? address,
    String? description,
    String? image,
    String? latitude,
    String? longitude,
  }) {
    return Restaurant(
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      image: image ?? this.image,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  String toString() {
    return 'Restaurant{name: $name, address: $address, description: $description, image: $image, latitude: $latitude, longitude: $longitude}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Restaurant &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          address == other.address &&
          description == other.description &&
          image == other.image &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode =>
      name.hashCode ^
      address.hashCode ^
      description.hashCode ^
      image.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
}
