import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/core/theme/app_solid_png_icons.dart';
import 'package:personalized_travel_recommendations/core/theme/app_outline_png_icons.dart';
import 'package:personalized_travel_recommendations/data/datasources/flight_data.dart';
import 'package:personalized_travel_recommendations/data/datasources/attractions_data.dart';
import 'package:personalized_travel_recommendations/data/datasources/restaurants_data.dart';
import 'package:personalized_travel_recommendations/data/datasources/accommodations_data.dart';
import 'package:personalized_travel_recommendations/data/datasources/travel_data.dart';
import 'package:personalized_travel_recommendations/data/models/models.dart';

class OrganizeTravelPackagesScreen extends StatefulWidget {
  final int dayIndex;
  final List<List<Map>> travelSchedule;
  final String? selectedCity;

  const OrganizeTravelPackagesScreen({
    super.key,
    required this.dayIndex,
    required this.travelSchedule,
    this.selectedCity,
  });

  @override
  State<OrganizeTravelPackagesScreen> createState() =>
      _OrganizeTravelPackagesScreenState();
}

class _OrganizeTravelPackagesScreenState
    extends State<OrganizeTravelPackagesScreen> {
  int selectedCategory = 0;
  String searchQuery = '';

  final List<String> categories = ['항공편', '관광명소', '맛집', '숙소'];

  // 카테고리별 스크롤 컨트롤러
  final Map<int, ScrollController> _scrollControllers = {};

  @override
  void initState() {
    super.initState();
    // 각 카테고리별로 스크롤 컨트롤러 초기화
    for (int i = 0; i < categories.length; i++) {
      _scrollControllers[i] = ScrollController();
    }
  }

  @override
  void dispose() {
    // 모든 스크롤 컨트롤러 정리
    for (var controller in _scrollControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // 통합된 여행 패키지 데이터 가져오기
  List<AddTravelModel> get currentTravelPackages {
    List<AddTravelModel> packages = [];
    String cityKey = widget.selectedCity ?? '제주';

    switch (selectedCategory) {
      case 0: // 항공편
        final flights = _getFlights(cityKey);
        packages = flights
            .map((flight) => AddTravelModel.fromFlight(
                  packageId: DateTime.now().millisecondsSinceEpoch.toString(),
                  tripId: 'temp_trip_id',
                  flight: flight,
                  date: DateTime.now(),
                  time: TimeOfDay(
                    hour: int.parse(flight.departureTime.split(':')[0]),
                    minute: int.parse(flight.departureTime.split(':')[1]),
                  ),
                  city: cityKey,
                ))
            .toList();
        break;
      case 1: // 관광명소
        final attractions = _getAttractions(cityKey);
        packages = attractions
            .map((attraction) => AddTravelModel.fromAttraction(
                  packageId: DateTime.now().millisecondsSinceEpoch.toString(),
                  tripId: 'temp_trip_id',
                  attraction: attraction,
                  date: DateTime.now(),
                  time: const TimeOfDay(hour: 0, minute: 0),
                  city: cityKey,
                ))
            .toList();
        break;
      case 2: // 맛집
        final restaurants = _getRestaurants(cityKey);
        packages = restaurants
            .map((restaurant) => AddTravelModel.fromRestaurant(
                  packageId: DateTime.now().millisecondsSinceEpoch.toString(),
                  tripId: 'temp_trip_id',
                  restaurant: restaurant,
                  date: DateTime.now(),
                  time: const TimeOfDay(hour: 0, minute: 0),
                  city: cityKey,
                ))
            .toList();
        break;
      case 3: // 숙소
        final accommodations = _getAccommodations(cityKey);
        packages = accommodations
            .map((accommodation) => AddTravelModel.fromAccommodation(
                  packageId: DateTime.now().millisecondsSinceEpoch.toString(),
                  tripId: 'temp_trip_id',
                  accommodation: accommodation,
                  date: DateTime.now(),
                  time: const TimeOfDay(hour: 0, minute: 0),
                  city: cityKey,
                ))
            .toList();
        break;
    }

    // 검색 기능
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      packages = packages
          .where((package) =>
              package.title.toLowerCase().contains(query) ||
              package.description.toLowerCase().contains(query) ||
              package.address.toLowerCase().contains(query))
          .toList();
    }

    return packages;
  }

  List<Flight> _getFlights(String cityKey) {
    if (cityKey == '자유' || cityKey == '자유 여행') {
      return FlightDataSource.getAllFlights();
    } else if (_isContinentOrCountry(cityKey)) {
      return _getFlightsByRegion(cityKey);
    } else {
      final flightsMap = FlightDataSource.getAllFlightsMap();
      return flightsMap[cityKey] ?? FlightDataSource.getJejuFlights();
    }
  }

  List<Attraction> _getAttractions(String cityKey) {
    if (cityKey == '자유' || cityKey == '자유 여행') {
      return AttractionDataSource.getAllAttractions();
    } else if (_isContinentOrCountry(cityKey)) {
      return _getAttractionsByRegion(cityKey);
    } else {
      final attractionsMap = AttractionDataSource.getAllAttractionsMap();
      return attractionsMap[cityKey] ??
          AttractionDataSource.getJejuAttractions();
    }
  }

  List<Restaurant> _getRestaurants(String cityKey) {
    if (cityKey == '자유' || cityKey == '자유 여행') {
      return RestaurantDataSource.getAllRestaurants();
    } else if (_isContinentOrCountry(cityKey)) {
      return _getRestaurantsByRegion(cityKey);
    } else {
      final restaurantsMap = RestaurantDataSource.getAllRestaurantsMap();
      return restaurantsMap[cityKey] ??
          RestaurantDataSource.getJejuRestaurants();
    }
  }

  List<Accommodation> _getAccommodations(String cityKey) {
    if (cityKey == '자유' || cityKey == '자유 여행') {
      return AccommodationDataSource.getAllAccommodations();
    } else if (_isContinentOrCountry(cityKey)) {
      return _getAccommodationsByRegion(cityKey);
    } else {
      final accommodationsMap =
          AccommodationDataSource.getAllAccommodationsMap();
      return accommodationsMap[cityKey] ??
          AccommodationDataSource.getJejuAccommodations();
    }
  }

  // 대륙 또는 나라인지 확인하는 함수
  bool _isContinentOrCountry(String region) {
    return TravelData.continents.contains(region) ||
        TravelData.continentCountries.values
            .any((countries) => countries.contains(region));
  }

  // 지역별 항공편 데이터 가져오기 - 모델 사용으로 수정
  List<Flight> _getFlightsByRegion(String region) {
    List<Flight> flights = [];

    if (TravelData.continents.contains(region)) {
      // 대륙이 선택된 경우
      final countries = TravelData.continentCountries[region] ?? [];
      for (String country in countries) {
        final cities = TravelData.countryCities[country] ?? [];
        for (String city in cities) {
          final flightsMap = FlightDataSource.getAllFlightsMap();
          flights.addAll(flightsMap[city] ?? []);
        }
      }
    } else {
      // 나라가 선택된 경우
      final cities = TravelData.countryCities[region] ?? [];
      for (String city in cities) {
        final flightsMap = FlightDataSource.getAllFlightsMap();
        flights.addAll(flightsMap[city] ?? []);
      }
    }

    return flights;
  }

  // 지역별 관광명소 데이터 가져오기 - 모델 사용으로 수정
  List<Attraction> _getAttractionsByRegion(String region) {
    List<Attraction> attractions = [];

    if (TravelData.continents.contains(region)) {
      final countries = TravelData.continentCountries[region] ?? [];
      for (String country in countries) {
        final cities = TravelData.countryCities[country] ?? [];
        for (String city in cities) {
          final attractionsMap = AttractionDataSource.getAllAttractionsMap();
          attractions.addAll(attractionsMap[city] ?? []);
        }
      }
    } else {
      final cities = TravelData.countryCities[region] ?? [];
      for (String city in cities) {
        final attractionsMap = AttractionDataSource.getAllAttractionsMap();
        attractions.addAll(attractionsMap[city] ?? []);
      }
    }

    return attractions;
  }

  // 지역별 레스토랑 데이터 가져오기 - 모델 사용으로 수정
  List<Restaurant> _getRestaurantsByRegion(String region) {
    List<Restaurant> restaurants = [];

    if (TravelData.continents.contains(region)) {
      final countries = TravelData.continentCountries[region] ?? [];
      for (String country in countries) {
        final cities = TravelData.countryCities[country] ?? [];
        for (String city in cities) {
          final restaurantsMap = RestaurantDataSource.getAllRestaurantsMap();
          restaurants.addAll(restaurantsMap[city] ?? []);
        }
      }
    } else {
      final cities = TravelData.countryCities[region] ?? [];
      for (String city in cities) {
        final restaurantsMap = RestaurantDataSource.getAllRestaurantsMap();
        restaurants.addAll(restaurantsMap[city] ?? []);
      }
    }

    return restaurants;
  }

  // 지역별 숙박 데이터 가져오기 - 모델 사용으로 수정
  List<Accommodation> _getAccommodationsByRegion(String region) {
    List<Accommodation> accommodations = [];

    if (TravelData.continents.contains(region)) {
      final countries = TravelData.continentCountries[region] ?? [];
      for (String country in countries) {
        final cities = TravelData.countryCities[country] ?? [];
        for (String city in cities) {
          final accommodationsMap =
              AccommodationDataSource.getAllAccommodationsMap();
          accommodations.addAll(accommodationsMap[city] ?? []);
        }
      }
    } else {
      final cities = TravelData.countryCities[region] ?? [];
      for (String city in cities) {
        final accommodationsMap =
            AccommodationDataSource.getAllAccommodationsMap();
        accommodations.addAll(accommodationsMap[city] ?? []);
      }
    }

    return accommodations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 52,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.neutral10,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppOutlinePngIcons.arrowNarrowLeft(
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Image.asset(
          'assets/logos/wordmark.png',
          width: 108,
          height: 22,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 2,
            color: AppColors.neutral10,
            width: double.infinity,
          ),
        ),
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
        toolbarHeight: 56,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildCategories(),
            Expanded(
              child: ListView.builder(
                controller: _scrollControllers[selectedCategory],
                padding: const EdgeInsets.all(16),
                itemCount: currentTravelPackages.length,
                itemBuilder: (context, index) {
                  final package = currentTravelPackages[index];
                  return GestureDetector(
                    onTap: () {
                      // AddTravelModel을 직접 반환
                      final selectedScheduleData = {
                        'place': package.title,
                        'address': package.address,
                        'price': package.price,
                        'time': package.time,
                        'latitude': package.latitude,
                        'longitude': package.longitude,
                        'travelPackage': package, // 전체 패키지 데이터 포함
                      };

                      Navigator.pop(context, selectedScheduleData);
                    },
                    child: _buildTravelPackageCard(package),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral10,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: '내용을 검색하세요',
            hintStyle: AppTypography.body14Regular.copyWith(
              color: AppColors.neutral50,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppSolidPngIcons.search(
                color: AppColors.neutral100,
                size: 20,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: AppColors.neutral30,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: AppColors.indigo60,
                width: 1.5,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: List.generate(categories.length, (index) {
            Widget? icon;
            switch (index) {
              case 0:
                icon = AppOutlinePngIcons.flight(
                    size: 20, color: AppColors.neutral100);
                break;
              case 1:
                icon = AppOutlinePngIcons.location(
                    size: 20, color: AppColors.neutral100);
                break;
              case 2:
                icon = AppOutlinePngIcons.tastehouse(
                    size: 20, color: AppColors.neutral100);
                break;
              case 3:
                icon = AppOutlinePngIcons.place(
                    size: 20, color: AppColors.neutral100);
                break;
            }
            return _buildCategoryButtonWithIcon(
              categories[index],
              icon,
              selectedCategory == index,
              onTap: () {
                setState(() {
                  selectedCategory = index;
                  searchQuery = ''; // 카테고리 변경 시 검색어 초기화
                });
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCategoryButtonWithIcon(
      String label, Widget? icon, bool isSelected,
      {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.neutral100,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          side: BorderSide(
            color: isSelected ? AppColors.indigo60 : AppColors.neutral30,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: AppTypography.caption12Medium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTravelPackageCard(AddTravelModel package) {
    final bool showImage = selectedCategory != 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral20, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showImage)
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: AppColors.neutral20,
                  child: Image.asset(
                    package.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: AppColors.neutral20,
                      child: Icon(
                        selectedCategory == 1
                            ? Icons.location_on
                            : selectedCategory == 2
                                ? Icons.restaurant
                                : Icons.hotel,
                        color: AppColors.neutral60,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: showImage ? 12 : 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    package.title,
                    style: AppTypography.subtitle16SemiBold,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    package.address,
                    style: AppTypography.body14Regular.copyWith(
                      color: AppColors.neutral60,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    package.description,
                    style: AppTypography.body14Regular.copyWith(
                      color: AppColors.neutral80,
                    ),
                    maxLines: showImage ? 2 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (package.price > 0) ...[
                    const SizedBox(height: 8),
                    Text(
                      '₩${package.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                      style: AppTypography.body14Medium.copyWith(
                        color: AppColors.indigo60,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
