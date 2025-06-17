class TripModel {
  final String tripId;
  final String userId;
  final String title;
  final String location;
  final String duration;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> tags;
  final int cities;
  final DateTime createdAt;

  TripModel({
    required this.tripId,
    required this.userId,
    required this.title,
    required this.location,
    required this.duration,
    required this.startDate,
    required this.endDate,
    required this.tags,
    required this.cities,
    required this.createdAt,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        tripId: json['tripId'],
        userId: json['userId'],
        title: json['title'],
        location: json['location'],
        duration: json['duration'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        tags: List<String>.from(json['tags'] ?? []),
        cities: json['cities'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'tripId': tripId,
        'userId': userId,
        'title': title,
        'location': location,
        'duration': duration,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'tags': tags,
        'cities': cities,
        'createdAt': createdAt.toIso8601String(),
      };
} 