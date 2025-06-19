class Attraction {
  final String name;
  final String address;
  final String description;
  final double latitude;
  final double longitude;
  final String image;

  Attraction({
    required this.name,
    required this.address,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.image,
  });

  // 안전한 double 변환을 위한 헬퍼 메서드
  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  factory Attraction.fromMap(Map<String, dynamic> map) {
    return Attraction(
      name: map['name'] as String,
      address: map['address'] as String,
      description: map['description'] as String,
      latitude: _toDouble(map['latitude']),
      longitude: _toDouble(map['longitude']),
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
    };
  }

  factory Attraction.fromJson(Map<String, dynamic> json) {
    return Attraction(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? 'assets/images/thumb-1.png',
      latitude: json['latitude'],
      longitude: json['longitude'],
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

  Attraction copyWith({
    String? name,
    String? address,
    String? description,
    String? image,
    double? latitude,
    double? longitude,
  }) {
    return Attraction(
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
    return 'Attraction{name: $name, address: $address, description: $description, image: $image, latitude: $latitude, longitude: $longitude}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Attraction &&
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
