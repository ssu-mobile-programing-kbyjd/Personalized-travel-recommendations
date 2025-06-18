class Flight {
  final String airline;
  final String departureTime;
  final String arrivalTime;
  final String departure;
  final String arrival;

  Flight({
    required this.airline,
    required this.departureTime,
    required this.arrivalTime,
    required this.departure,
    required this.arrival,
  });

  factory Flight.fromMap(Map<String, String> map) {
    return Flight(
      airline: map['airline'] ?? '',
      departureTime: map['departure_time'] ?? '',
      arrivalTime: map['arrival_time'] ?? '',
      departure: map['departure'] ?? '',
      arrival: map['arrival'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'airline': airline,
      'departure_time': departureTime,
      'arrival_time': arrivalTime,
      'departure': departure,
      'arrival': arrival,
    };
  }

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      airline: json['airline'] ?? '',
      departureTime: json['departure_time'] ?? '',
      arrivalTime: json['arrival_time'] ?? '',
      departure: json['departure'] ?? '',
      arrival: json['arrival'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airline': airline,
      'departure_time': departureTime,
      'arrival_time': arrivalTime,
      'departure': departure,
      'arrival': arrival,
    };
  }

  Flight copyWith({
    String? airline,
    String? departureTime,
    String? arrivalTime,
    String? departure,
    String? arrival,
  }) {
    return Flight(
      airline: airline ?? this.airline,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
    );
  }

  @override
  String toString() {
    return 'Flight{airline: $airline, departureTime: $departureTime, arrivalTime: $arrivalTime, departure: $departure, arrival: $arrival}';
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
          arrival == other.arrival;

  @override
  int get hashCode =>
      airline.hashCode ^
      departureTime.hashCode ^
      arrivalTime.hashCode ^
      departure.hashCode ^
      arrival.hashCode;
}
