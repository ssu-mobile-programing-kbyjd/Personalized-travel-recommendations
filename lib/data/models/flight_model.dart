class Flight {
  final String airline;
  final String departureTime;
  final String arrivalTime;
  final String departure;
  final String arrival;
  final double latitude;
  final double longitude;

  Flight({
    required this.airline,
    required this.departureTime,
    required this.arrivalTime,
    required this.departure,
    required this.arrival,
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      airline: map['airline'] ?? '',
      departureTime: map['departure_time'] ?? '',
      arrivalTime: map['arrival_time'] ?? '',
      departure: map['departure'] ?? '',
      arrival: map['arrival'] ?? '',
      latitude: 0.0,
      longitude: 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'airline': airline,
      'departure_time': departureTime,
      'arrival_time': arrivalTime,
      'departure': departure,
      'arrival': arrival,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      airline: json['airline'] ?? '',
      departureTime: json['departure_time'] ?? '',
      arrivalTime: json['arrival_time'] ?? '',
      departure: json['departure'] ?? '',
      arrival: json['arrival'] ?? '',
      latitude: 0.0,
      longitude: 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airline': airline,
      'departure_time': departureTime,
      'arrival_time': arrivalTime,
      'departure': departure,
      'arrival': arrival,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  Flight copyWith({
    String? airline,
    String? departureTime,
    String? arrivalTime,
    String? departure,
    String? arrival,
    double? latitude,
    double? longitude,
  }) {
    return Flight(
      airline: airline ?? this.airline,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  String toString() {
    return 'Flight{airline: $airline, departureTime: $departureTime, arrivalTime: $arrivalTime, departure: $departure, arrival: $arrival, latitude: $latitude, longitude: $longitude}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Flight &&
          runtimeType == other.runtimeType &&
          airline == other.airline &&
          departureTime == other.departureTime &&
          arrivalTime == other.arrivalTime &&
          departure == other.departure &&
          arrival == other.arrival &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode =>
      airline.hashCode ^
      departureTime.hashCode ^
      arrivalTime.hashCode ^
      departure.hashCode ^
      arrival.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
}
