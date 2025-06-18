class Accommodation {
  final String name;
  final String address;
  final String description;
  final String image;

  Accommodation({
    required this.name,
    required this.address,
    required this.description,
    required this.image,
  });

  factory Accommodation.fromMap(Map<String, String> map) {
    return Accommodation(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? 'assets/images/thumb-1.png',
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'image': image,
    };
  }

  factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? 'assets/images/thumb-1.png',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'image': image,
    };
  }

  Accommodation copyWith({
    String? name,
    String? address,
    String? description,
    String? image,
  }) {
    return Accommodation(
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'Accommodation{name: $name, address: $address, description: $description, image: $image}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Accommodation &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          address == other.address &&
          description == other.description &&
          image == other.image;

  @override
  int get hashCode =>
      name.hashCode ^ address.hashCode ^ description.hashCode ^ image.hashCode;
}
