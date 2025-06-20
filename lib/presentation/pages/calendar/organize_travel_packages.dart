import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/core/theme/app_solid_png_icons.dart';
import 'package:personalized_travel_recommendations/core/theme/app_outline_png_icons.dart';
import 'package:personalized_travel_recommendations/data/datasources/travel_data.dart';
import 'package:personalized_travel_recommendations/data/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 통합된 여행 패키지 데이터 가져오기
  // 항공편 데이터 가져오기
  Future<List<Map<String, dynamic>>> fetchFlights(String cityKey) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('flights').get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  // 관광명소 데이터 가져오기
  Future<List<Map<String, dynamic>>> fetchAttractions(String cityKey) async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection('attractions');
    final snapshot = await ref.get();
    final allDocs =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    if (cityKey.isEmpty || cityKey == '전체') {
      return allDocs;
    }
    return allDocs.where((doc) {
      final city = (doc['city'] ?? '').toString();
      final title = (doc['title'] ?? '').toString();
      final description = (doc['description'] ?? '').toString();
      final address = (doc['address'] ?? '').toString();
      return city.contains(cityKey) ||
          title.contains(cityKey) ||
          description.contains(cityKey) ||
          address.contains(cityKey);
    }).toList();
  }

  // 맛집 데이터 가져오기
  Future<List<Map<String, dynamic>>> fetchRestaurants(String cityKey) async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection('restaurants');
    final snapshot = await ref.get();
    final allDocs =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    if (cityKey.isEmpty || cityKey == '전체') {
      return allDocs;
    }
    return allDocs.where((doc) {
      final city = (doc['city'] ?? '').toString();
      final title = (doc['title'] ?? '').toString();
      final description = (doc['description'] ?? '').toString();
      final address = (doc['address'] ?? '').toString();
      return city.contains(cityKey) ||
          title.contains(cityKey) ||
          description.contains(cityKey) ||
          address.contains(cityKey);
    }).toList();
  }

  // 숙소 데이터 가져오기
  Future<List<Map<String, dynamic>>> fetchAccommodations(String cityKey) async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection('accommodations');
    final snapshot = await ref.get();
    final allDocs =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    if (cityKey.isEmpty || cityKey == '전체') {
      return allDocs;
    }
    return allDocs.where((doc) {
      final city = (doc['city'] ?? '').toString();
      final title = (doc['title'] ?? '').toString();
      final description = (doc['description'] ?? '').toString();
      final address = (doc['address'] ?? '').toString();
      return city.contains(cityKey) ||
          title.contains(cityKey) ||
          description.contains(cityKey) ||
          address.contains(cityKey);
    }).toList();
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
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchDataByCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('해당 패키지가 없습니다.'));
                  }
                  final dataList = snapshot.data!;
                  // 검색 필터 적용
                  final filtered = searchQuery.isNotEmpty
                      ? dataList.where((item) {
                          final title =
                              (item['title'] ?? '').toString().toLowerCase();
                          final description = (item['description'] ?? '')
                              .toString()
                              .toLowerCase();
                          final address =
                              (item['address'] ?? '').toString().toLowerCase();
                          final query = searchQuery.toLowerCase();
                          return title.contains(query) ||
                              description.contains(query) ||
                              address.contains(query);
                        }).toList()
                      : dataList;
                  final packages = filtered.map((item) {
                    switch (selectedCategory) {
                      case 0:
                        return AddTravelModel.fromFlight(
                          packageId:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          tripId: 'temp_trip_id',
                          flight: Flight.fromJson(item),
                          date: DateTime.now(),
                          time: TimeOfDay(
                            hour: int.parse(
                                (item['departureTime'] ?? '0:0').split(':')[0]),
                            minute: int.parse(
                                (item['departureTime'] ?? '0:0').split(':')[1]),
                          ),
                          city: widget.selectedCity ?? '제주',
                        );
                      case 1:
                        return AddTravelModel.fromAttraction(
                          packageId:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          tripId: 'temp_trip_id',
                          attraction: Attraction.fromJson(item),
                          date: DateTime.now(),
                          time: const TimeOfDay(hour: 0, minute: 0),
                          city: widget.selectedCity ?? '제주',
                        );
                      case 2:
                        return AddTravelModel.fromRestaurant(
                          packageId:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          tripId: 'temp_trip_id',
                          restaurant: Restaurant.fromJson(item),
                          date: DateTime.now(),
                          time: const TimeOfDay(hour: 0, minute: 0),
                          city: widget.selectedCity ?? '제주',
                        );
                      case 3:
                        return AddTravelModel.fromAccommodation(
                          packageId:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          tripId: 'temp_trip_id',
                          accommodation: AccommodationModel.fromJson(item),
                          date: DateTime.now(),
                          time: const TimeOfDay(hour: 0, minute: 0),
                          city: widget.selectedCity ?? '제주',
                        );
                      default:
                        return AddTravelModel.fromFlight(
                          packageId:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          tripId: 'temp_trip_id',
                          flight: Flight.fromJson(item),
                          date: DateTime.now(),
                          time: TimeOfDay(
                            hour: int.parse(
                                (item['departureTime'] ?? '0:0').split(':')[0]),
                            minute: int.parse(
                                (item['departureTime'] ?? '0:0').split(':')[1]),
                          ),
                          city: widget.selectedCity ?? '제주',
                        );
                    }
                  }).toList();
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: packages.length,
                    itemBuilder: (context, index) {
                      final package = packages[index];
                      return GestureDetector(
                        onTap: () {
                          final selectedScheduleData = {
                            'place': package.title,
                            'address': package.address,
                            'price': package.price,
                            'time': package.time,
                            'lat': package.locationLatitude,
                            'lng': package.locationLongitude,
                            'travelPackage': package,
                          };
                          Navigator.pop(context, selectedScheduleData);
                        },
                        child: _buildTravelPackageCard(package),
                      );
                    },
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

  // 카테고리에 따라 Firestore에서 데이터 가져오기
  Future<List<Map<String, dynamic>>> _fetchDataByCategory() {
    final cityKey = widget.selectedCity ?? '제주';
    switch (selectedCategory) {
      case 0:
        return fetchFlights(cityKey);
      case 1:
        return fetchAttractions(cityKey);
      case 2:
        return fetchRestaurants(cityKey);
      case 3:
        return fetchAccommodations(cityKey);
      default:
        return fetchFlights(cityKey);
    }
  }
}
