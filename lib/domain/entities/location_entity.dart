class LocationEntity {
  final String continent;
  final String country;
  final String city;

  const LocationEntity({
    required this.continent,
    required this.country,
    required this.city,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationEntity &&
          runtimeType == other.runtimeType &&
          continent == other.continent &&
          country == other.country &&
          city == other.city;

  @override
  int get hashCode => continent.hashCode ^ country.hashCode ^ city.hashCode;

  @override
  String toString() {
    return 'LocationEntity(continent: $continent, country: $country, city: $city)';
  }
} 