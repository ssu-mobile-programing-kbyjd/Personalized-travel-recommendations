import 'package:personalized_travel_recommendations/data/datasources/location_data_source.dart';
import 'package:personalized_travel_recommendations/domain/entities/location_entity.dart';

class LocationUseCase {
  List<String> getContinents() {
    return LocationDataSource.getContinents();
  }

  List<String> getCountries(String continent) {
    return LocationDataSource.getCountries(continent);
  }

  List<String> getCities(String continent, String country) {
    return LocationDataSource.getCities(continent, country);
  }

  bool isValidLocation(String continent, String country, String city) {
    final countries = getCountries(continent);
    if (!countries.contains(country)) return false;
    
    final cities = getCities(continent, country);
    return cities.contains(city);
  }

  LocationEntity createLocation(String continent, String country, String city) {
    if (!isValidLocation(continent, country, city)) {
      throw ArgumentError('Invalid location combination');
    }
    
    return LocationEntity(
      continent: continent,
      country: country,
      city: city,
    );
  }
} 