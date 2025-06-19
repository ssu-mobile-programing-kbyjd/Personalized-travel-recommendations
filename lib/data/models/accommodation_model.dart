class Accommodation {
  final String name;
  final String address;
  final String description;
  final double latitude;
  final double longitude;
  final String image;

  Accommodation({
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

  factory Accommodation.fromMap(Map<String, dynamic> map) {
    return Accommodation(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      description: map['description'] ?? '',
      latitude: _toDouble(map['latitude']),
      longitude: _toDouble(map['longitude']),
      image: map['image'] ?? 'assets/images/thumb-1.png',
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

  factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
      image: json['image'] ?? 'assets/images/thumb-1.png',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
    };
  }

  Accommodation copyWith({
    String? name,
    String? address,
    String? description,
    double? latitude,
    double? longitude,
    String? image,
  }) {
    return Accommodation(
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'Accommodation{name: $name, address: $address, description: $description, latitude: $latitude, longitude: $longitude, image: $image}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Accommodation &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          address == other.address &&
          description == other.description &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          image == other.image;

  @override
  int get hashCode =>
      name.hashCode ^
      address.hashCode ^
      description.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      image.hashCode;
}
