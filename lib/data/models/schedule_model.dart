class ScheduleModel {
  final String scheduleId;
  final String tripId;
  final String title;
  final String description;
  final DateTime date;
  final List<String> places;
  final DateTime createdAt;

  ScheduleModel({
    required this.scheduleId,
    required this.tripId,
    required this.title,
    required this.description,
    required this.date,
    required this.places,
    required this.createdAt,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        scheduleId: json['scheduleId'],
        tripId: json['tripId'],
        title: json['title'],
        description: json['description'],
        date: DateTime.parse(json['date']),
        places: List<String>.from(json['places'] ?? []),
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'scheduleId': scheduleId,
        'tripId': tripId,
        'title': title,
        'description': description,
        'date': date.toIso8601String(),
        'places': places,
        'createdAt': createdAt.toIso8601String(),
      };
} 