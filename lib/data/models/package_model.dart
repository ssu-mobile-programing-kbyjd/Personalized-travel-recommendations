class PackageModel {
  final String packageId;
  final String title;
  final String description;
  final int price;
  final String imageUrl;
  final DateTime createdAt;

  PackageModel({
    required this.packageId,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.createdAt,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        packageId: json['packageId'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['imageUrl'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'packageId': packageId,
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'createdAt': createdAt.toIso8601String(),
      };
} 