import 'package:flutter/material.dart';
import 'accommodation_model.dart';
import 'attraction_model.dart';
import 'flight_model.dart';
import 'restaurant_model.dart';

class AddTravelModel {
  final String packageId;
  final String tripId;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final int price;
  final String
      category; // 'flight', 'attraction', 'restaurant', 'accommodation'
  final String city;
  final double? latitude;
  final double? longitude;
  final Flight? flight;
  final Attraction? attraction;
  final Restaurant? restaurant;
  final AccommodationModel? accommodation;
  final DateTime createdAt;

  AddTravelModel({
    required this.packageId,
    required this.tripId,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.price,
    required this.category,
    required this.city,
    this.latitude,
    this.longitude,
    this.flight,
    this.attraction,
    this.restaurant,
    this.accommodation,
    required this.createdAt,
  });

  factory AddTravelModel.fromFlight({
    required String packageId,
    required String tripId,
    required Flight flight,
    required DateTime date,
    required TimeOfDay time,
    required String city,
    double? latitude,
    double? longitude,
  }) {
    return AddTravelModel(
      packageId: packageId,
      tripId: tripId,
      title: '${flight.airline}',
      description: '${flight.departureTime} → ${flight.arrivalTime}',
      date: date,
      time: time,
      price: 0,
      category: 'flight',
      city: city,
      latitude: latitude ?? flight.latitude,
      longitude: longitude ?? flight.longitude,
      flight: flight,
      createdAt: DateTime.now(),
    );
  }

  factory AddTravelModel.fromAttraction({
    required String packageId,
    required String tripId,
    required Attraction attraction,
    required DateTime date,
    required TimeOfDay time,
    required String city,
    double? latitude,
    double? longitude,
  }) {
    return AddTravelModel(
      packageId: packageId,
      tripId: tripId,
      title: attraction.name,
      description: attraction.description,
      date: date,
      time: time,
      price: 0,
      category: 'attraction',
      city: city,
      latitude: latitude ?? attraction.latitude,
      longitude: longitude ?? attraction.longitude,
      attraction: attraction,
      createdAt: DateTime.now(),
    );
  }

  factory AddTravelModel.fromRestaurant({
    required String packageId,
    required String tripId,
    required Restaurant restaurant,
    required DateTime date,
    required TimeOfDay time,
    required String city,
    double? latitude,
    double? longitude,
  }) {
    return AddTravelModel(
      packageId: packageId,
      tripId: tripId,
      title: restaurant.name,
      description: restaurant.description,
      date: date,
      time: time,
      price: 25000,
      category: 'restaurant',
      city: city,
      latitude: latitude ?? restaurant.latitude,
      longitude: longitude ?? restaurant.longitude,
      restaurant: restaurant,
      createdAt: DateTime.now(),
    );
  }

  factory AddTravelModel.fromAccommodation({
    required String packageId,
    required String tripId,
    required AccommodationModel accommodation,
    required DateTime date,
    required TimeOfDay time,
    required String city,
    double? latitude,
    double? longitude,
  }) {
    return AddTravelModel(
      packageId: packageId,
      tripId: tripId,
      title: accommodation.name,
      description: accommodation.description,
      date: date,
      time: time,
      price: 120000,
      category: 'accommodation',
      city: city,
      latitude: latitude ?? accommodation.latitude,
      longitude: longitude ?? accommodation.longitude,
      accommodation: accommodation,
      createdAt: DateTime.now(),
    );
  }

  factory AddTravelModel.fromJson(Map<String, dynamic> json) {
    final timeData = json['time'] as Map<String, dynamic>?;
    final time = timeData != null
        ? TimeOfDay(hour: timeData['hour'], minute: timeData['minute'])
        : const TimeOfDay(hour: 0, minute: 0);

    return AddTravelModel(
      packageId: json['packageId'],
      tripId: json['tripId'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      time: time,
      price: json['price'],
      category: json['category'],
      city: json['city'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      flight: json['flight'] != null ? Flight.fromJson(json['flight']) : null,
      attraction: json['attraction'] != null
          ? Attraction.fromJson(json['attraction'])
          : null,
      restaurant: json['restaurant'] != null
          ? Restaurant.fromJson(json['restaurant'])
          : null,
      accommodation: json['accommodation'] != null
          ? AccommodationModel.fromJson(json['accommodation'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'packageId': packageId,
        'tripId': tripId,
        'title': title,
        'description': description,
        'date': date.toIso8601String(),
        'time': {'hour': time.hour, 'minute': time.minute},
        'price': price,
        'category': category,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
        'flight': flight?.toJson(),
        'attraction': attraction?.toJson(),
        'restaurant': restaurant?.toJson(),
        'accommodation': accommodation?.toJson(),
        'createdAt': createdAt.toIso8601String(),
      };

  String get address {
    switch (category) {
      case 'flight':
        return '${flight?.departure} → ${flight?.arrival}';
      case 'attraction':
        return attraction?.address ?? '';
      case 'restaurant':
        return restaurant?.address ?? '';
      case 'accommodation':
        return accommodation?.address ?? '';
      default:
        return '';
    }
  }

  double get locationLatitude {
    switch (category) {
      case 'attraction':
        return attraction?.latitude ?? 0.0;
      case 'restaurant':
        return restaurant?.latitude ?? 0.0;
      case 'accommodation':
        return accommodation?.latitude ?? 0.0;
      default:
        return 0.0;
    }
  }

  double get locationLongitude {
    switch (category) {
      case 'attraction':
        return attraction?.longitude ?? 0.0;
      case 'restaurant':
        return restaurant?.longitude ?? 0.0;
      case 'accommodation':
        return accommodation?.longitude ?? 0.0;
      default:
        return 0.0;
    }
  }

  String get imageUrl {
    switch (category) {
      case 'attraction':
        return attraction?.image ?? 'assets/images/thumb-1.png';
      case 'restaurant':
        return restaurant?.image ?? 'assets/images/thumb-1.png';
      case 'accommodation':
        return accommodation?.image ?? 'assets/images/thumb-1.png';
      default:
        return 'assets/images/thumb-1.png';
    }
  }

  AddTravelModel copyWith({
    String? packageId,
    String? tripId,
    String? title,
    String? description,
    DateTime? date,
    TimeOfDay? time,
    int? price,
    String? category,
    String? city,
    double? latitude,
    double? longitude,
    Flight? flight,
    Attraction? attraction,
    Restaurant? restaurant,
    AccommodationModel? accommodation,
    DateTime? createdAt,
  }) {
    return AddTravelModel(
      packageId: packageId ?? this.packageId,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      price: price ?? this.price,
      category: category ?? this.category,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      flight: flight ?? this.flight,
      attraction: attraction ?? this.attraction,
      restaurant: restaurant ?? this.restaurant,
      accommodation: accommodation ?? this.accommodation,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddTravelModel &&
          runtimeType == other.runtimeType &&
          packageId == other.packageId;

  @override
  int get hashCode => packageId.hashCode;
}
