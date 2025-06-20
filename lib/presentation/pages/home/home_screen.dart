import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'trending_destinations_screen.dart';
import 'travel_packages_screen.dart';
import '/presentation/pages/home/influencers_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../create_dummy_data.dart';
import 'package:personalized_travel_recommendations/data/datasources/travel_data.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/presentation/utils/webview_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/mypage/guest_my_page_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/main_screen.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/presentation/pages/home/destination_detail_screen.dart';

class MainHomeScreen extends StatefulWidget {
  final bool isLoggedIn;
  const MainHomeScreen({super.key, this.isLoggedIn = false});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final PageController _bannerPageController = PageController();
  int _currentBannerPage = 0;
  int _selectedCategoryIndex = 0;

  // TravelData에서 위치 데이터 사용
  final Map<String, List<String>> _locationData = TravelData.continentCountries;
  final Map<String, List<String>> countryCities = TravelData.countryCities;
  final List<String> continents = TravelData.continents;

  String? _selectedContinent;
  String? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedContinent = '북아메리카';
    _selectedCountry = '미국';
    _uploadDummyDataOnce();
  }

  Future<void> _uploadDummyDataOnce() async {
    final prefs = await SharedPreferences.getInstance();
    final uploaded = prefs.getBool('dummyDataUploaded') ?? false;
    if (!uploaded) {
      await uploadDummyData();
      await prefs.setBool('dummyDataUploaded', true);
    }
  }

  @override
  void dispose() {
    _bannerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildCategorySection(),
              _buildMainContentBanner(),
              _buildTrendingDestinations(),
              _buildRecentPackages(),
              _buildCustomInfluencers(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // 위치 아이콘 (플레이스홀더)
          Image.asset(
            'assets/logos/Symbol.png',
            width: 33,
            height: 49,
          ),
          const SizedBox(width: 8),
          // 현재 위치 정보 (인라인 위치 선택)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '당신은 지금,',
                  style: AppTypography.caption12Regular.copyWith(
                    color: AppColors.neutral60,
                  ),
                ),
                const SizedBox(height: 4),
                _buildInlineLocationButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineLocationButton() {
    return GestureDetector(
      onTap: _showLocationSelector,
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            size: 20,
            color: AppColors.neutral100,
          ),
          const SizedBox(width: 4),
          Text(
            _selectedCountry != null ? _selectedCountry! : '위치를 선택해주세요',
            style: AppTypography.body14SemiBold.copyWith(
              color: _selectedCountry != null
                  ? AppColors.neutral100
                  : AppColors.neutral50,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: AppColors.neutral60,
          ),
        ],
      ),
    );
  }

  void _showLocationSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: AppColors.white,
      builder: (context) {
        String? tempContinent = _selectedContinent;
        String? tempCountry = _selectedCountry;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 핸들바
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.neutral30,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 제목
                  Text(
                    '위치 선택',
                    style: AppTypography.subtitle20Bold.copyWith(
                      color: AppColors.neutral100,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 대륙 선택
                  Text(
                    '대륙',
                    style: AppTypography.body14SemiBold.copyWith(
                      color: AppColors.neutral100,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.neutral30),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      value: tempContinent,
                      hint: Text(
                        '대륙을 선택해주세요',
                        style: AppTypography.body14Regular.copyWith(
                          color: AppColors.neutral60,
                        ),
                      ),
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: AppColors.neutral60),
                      items: _locationData.keys.map((continent) {
                        return DropdownMenuItem(
                          value: continent,
                          child: Text(
                            continent,
                            style: AppTypography.body14Regular.copyWith(
                              color: AppColors.neutral100,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setModalState(() {
                          tempContinent = value;
                          tempCountry = null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 국가 선택
                  Text(
                    '국가',
                    style: AppTypography.body14SemiBold.copyWith(
                      color: AppColors.neutral100,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: tempContinent == null
                            ? AppColors.neutral20
                            : AppColors.neutral30,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: tempContinent == null
                          ? AppColors.neutral10
                          : AppColors.white,
                    ),
                    child: DropdownButton<String>(
                      value: tempCountry,
                      hint: Text(
                        tempContinent == null ? '먼저 대륙을 선택해주세요' : '국가를 선택해주세요',
                        style: AppTypography.body14Regular.copyWith(
                          color: AppColors.neutral60,
                        ),
                      ),
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: tempContinent == null
                            ? AppColors.neutral40
                            : AppColors.neutral60,
                      ),
                      items: tempContinent != null
                          ? _locationData[tempContinent!]!.map((country) {
                              return DropdownMenuItem(
                                value: country,
                                child: Text(
                                  country,
                                  style: AppTypography.body14Regular.copyWith(
                                    color: AppColors.neutral100,
                                  ),
                                ),
                              );
                            }).toList()
                          : null,
                      onChanged: tempContinent != null
                          ? (value) {
                              setModalState(() {
                                tempCountry = value;
                              });
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // 버튼 영역
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.neutral60,
                            side: const BorderSide(color: AppColors.neutral30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            '취소',
                            style: AppTypography.body14Medium.copyWith(
                              color: AppColors.neutral60,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: tempCountry != null
                              ? () {
                                  setState(() {
                                    _selectedContinent = tempContinent;
                                    _selectedCountry = tempCountry;
                                    _selectedCategoryIndex = 0;
                                  });
                                  Navigator.pop(context);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tempCountry != null
                                ? AppColors.indigo60
                                : AppColors.neutral30,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                          ),
                          child: Text(
                            '선택 완료',
                            style: AppTypography.body14Medium.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCategorySection() {
    final cities = countryCities[_selectedCountry] ?? [];
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      height: 46, // 패딩 증가로 높이 조정
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          final isSelected = index == _selectedCategoryIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(
                  right:
                      index < cities.length - 1 ? 12 : 0), // 16에서 12로 변경 (4 줄임)
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12), // 8에서 12로 변경 (4 늘림)
              decoration: BoxDecoration(
                color: isSelected ? AppColors.indigo60 : AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? AppColors.indigo60 : AppColors.neutral30,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_city,
                    size: 20,
                    color: isSelected ? AppColors.white : AppColors.neutral60,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    city,
                    style: AppTypography.body14Medium.copyWith(
                      color: isSelected ? AppColors.white : AppColors.neutral60,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingDestinations() {
    final cities = countryCities[_selectedCountry] ?? [];
    final selectedCategory =
        (cities.isNotEmpty && _selectedCategoryIndex < cities.length)
            ? cities[_selectedCategoryIndex]
            : null;
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '요즘 뜨는 여행지',
                style: AppTypography.subtitle16SemiBold.copyWith(
                  color: AppColors.neutral100,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrendingDestinationsScreen(
                        country: _selectedCountry!,
                        cityList: cities,
                        selectedCityIndex: _selectedCategoryIndex,
                      ),
                    ),
                  );
                },
                child: Text(
                  '전체 보기',
                  style: AppTypography.body14Medium.copyWith(
                    color: AppColors.indigo60,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: (selectedCategory == null)
                ? const Center(child: Text('국가를 선택하세요'))
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('destinations')
                        .where('category', isEqualTo: selectedCategory)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final docs = snapshot.data!.docs;
                      if (docs.isEmpty) {
                        return const Center(child: Text('No data found'));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          final data = doc.data() as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DestinationDetailScreen(
                                    name: data['name'] ?? '',
                                    location: data['location'] ?? '',
                                    rating: (data['rating'] is num)
                                        ? (data['rating'] as num).toDouble()
                                        : 0.0,
                                    hits: (data['hits'] is int)
                                        ? data['hits']
                                        : int.tryParse(
                                                data['hits']?.toString() ??
                                                    '') ??
                                            0,
                                    description: data['description'] ?? '',
                                    imageUrl: data['image'] ?? '',
                                  ),
                                ),
                              );
                            },
                            child: _buildDestinationCardFromFirestore(
                                data, doc.id),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCardFromFirestore(
      Map<String, dynamic> data, String docId) {
    final isLiked = data['isLiked'] == true;
    return Stack(
      children: [
        Container(
          width: 257,
          margin: const EdgeInsets.only(bottom: 30, right: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 182,
                width: double.infinity,
                child: (data['image'] != null &&
                        data['image'].toString().isNotEmpty)
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Stack(
                          children: [
                            Image.network(
                              data['image'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 182,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.grey[200]),
                            ),
                            Container(
                              width: double.infinity,
                              height: 182,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                        ),
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data['name'] ?? '',
                            style: AppTypography.body14Medium.copyWith(
                              color: AppColors.neutral100,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (data['rating'] != null) ...[
                          Row(
                            children: [
                              Image.asset('assets/icons/Solid/png/star.png',
                                  width: 18,
                                  height: 18,
                                  color: AppColors.warning40),
                              const SizedBox(width: 4),
                              Text('${data['rating']}',
                                  style: AppTypography.body14SemiBold
                                      .copyWith(color: AppColors.neutral100)),
                            ],
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['location'] ?? '',
                      style: AppTypography.caption12Regular.copyWith(
                        color: AppColors.neutral60,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (data['hits'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '${data['hits']}명이 확인 중',
                          style: AppTypography.subtitle16SemiBold.copyWith(
                            color: AppColors.indigo60,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 13,
          right: 27,
          child: GestureDetector(
            onTap: () async {
              if (!widget.isLoggedIn) {
                final result = await LoginRequiredDialog.show(context);
                if (result == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const MainScreen(initialIndex: 2, isLoggedIn: false),
                    ),
                  );
                }
                return;
              }
              await FirebaseFirestore.instance
                  .collection('destinations')
                  .doc(docId)
                  .update({'isLiked': !isLiked});
            },
            child: Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              child: Image.asset(
                !widget.isLoggedIn
                    ? 'assets/icons/Outline/png/heartx.png'
                    : (isLiked
                        ? 'assets/icons/Solid/png/heart-1.png'
                        : 'assets/icons/Outline/png/heartx.png'),
                width: 26,
                height: 26,
                fit: BoxFit.contain,
                color: AppColors.error60,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentPackages() {
    final cities = countryCities[_selectedCountry] ?? [];
    final selectedCategory =
        (cities.isNotEmpty && _selectedCategoryIndex < cities.length)
            ? cities[_selectedCategoryIndex]
            : null;
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '최근 업데이트 된 여행 패키지',
                style: AppTypography.subtitle16SemiBold.copyWith(
                  color: AppColors.neutral100,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TravelPackagesScreen(
                        country: _selectedCountry!,
                        cityList: cities,
                        selectedCityIndex: _selectedCategoryIndex,
                      ),
                    ),
                  );
                },
                child: Text(
                  '전체 보기',
                  style: AppTypography.body14Medium.copyWith(
                    color: AppColors.indigo60,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: (selectedCategory == null)
                ? const Center(child: Text('국가를 선택하세요'))
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('packages')
                        .where('category', isEqualTo: selectedCategory)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final docs = snapshot.data!.docs;
                      if (docs.isEmpty) {
                        return const Center(child: Text('No data found'));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          final data = doc.data() as Map<String, dynamic>;
                          return _buildPackageCardFromFirestore(data, doc.id);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCardFromFirestore(
      Map<String, dynamic> data, String docId) {
    final isLiked = data['isLiked'] == true;
    return Stack(
      children: [
        Container(
          width: 257,
          margin: const EdgeInsets.only(bottom: 30, right: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 182,
                width: double.infinity,
                child: (data['image'] != null &&
                        data['image'].toString().isNotEmpty)
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Stack(
                          children: [
                            Image.network(
                              data['image'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 182,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.grey[200]),
                            ),
                            Container(
                              width: double.infinity,
                              height: 182,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                        ),
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data['name'] ?? '',
                            style: AppTypography.body14Medium.copyWith(
                              color: AppColors.neutral100,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (data['rating'] != null) ...[
                          Row(
                            children: [
                              Image.asset('assets/icons/Solid/png/star.png',
                                  width: 18,
                                  height: 18,
                                  color: AppColors.warning40),
                              const SizedBox(width: 4),
                              Text('${data['rating']}',
                                  style: AppTypography.body14SemiBold
                                      .copyWith(color: AppColors.neutral100)),
                            ],
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['location'] ?? '',
                      style: AppTypography.caption12Regular.copyWith(
                        color: AppColors.neutral60,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (data['hits'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '${data['hits']}명이 확인 중',
                          style: AppTypography.subtitle16SemiBold.copyWith(
                            color: AppColors.indigo60,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 13,
          right: 27,
          child: GestureDetector(
            onTap: () async {
              if (!widget.isLoggedIn) {
                final result = await LoginRequiredDialog.show(context);
                if (result == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const MainScreen(initialIndex: 2, isLoggedIn: false),
                    ),
                  );
                }
                return;
              }
              await FirebaseFirestore.instance
                  .collection('packages')
                  .doc(docId)
                  .update({'isLiked': !isLiked});
            },
            child: Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              child: Image.asset(
                !widget.isLoggedIn
                    ? 'assets/icons/Outline/png/heartx.png'
                    : (isLiked
                        ? 'assets/icons/Solid/png/heart-1.png'
                        : 'assets/icons/Outline/png/heartx.png'),
                width: 26,
                height: 26,
                fit: BoxFit.contain,
                color: AppColors.error60,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomInfluencers() {
    final cities = countryCities[_selectedCountry] ?? [];
    final selectedCategory =
        (cities.isNotEmpty && _selectedCategoryIndex < cities.length)
            ? cities[_selectedCategoryIndex]
            : null;
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '맞춤 트립인플루언서',
                style: AppTypography.subtitle16SemiBold.copyWith(
                  color: AppColors.neutral100,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfluencersScreen(
                        country: _selectedCountry!,
                        cityList: cities,
                        selectedCityIndex: _selectedCategoryIndex,
                      ),
                    ),
                  );
                },
                child: Text(
                  '전체 보기',
                  style: AppTypography.body14Medium.copyWith(
                    color: AppColors.indigo60,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: (selectedCategory == null)
                ? const Center(child: Text('국가를 선택하세요'))
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('influencers')
                        .where('category', isEqualTo: selectedCategory)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final docs = snapshot.data!.docs;
                      if (docs.isEmpty) {
                        return const Center(child: Text('No data found'));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          final data = doc.data() as Map<String, dynamic>;
                          return _buildInfluencerCardFromFirestore(
                              data, doc.id);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfluencerCardFromFirestore(
      Map<String, dynamic> data, String docId) {
    final isLiked = data['isLiked'] == true;
    return Stack(
      children: [
        Container(
          width: 257,
          margin: const EdgeInsets.only(bottom: 30, right: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 182,
                width: double.infinity,
                child: (data['image'] != null &&
                        data['image'].toString().isNotEmpty)
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Stack(
                          children: [
                            Image.network(
                              data['image'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 182,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.grey[200]),
                            ),
                            Container(
                              width: double.infinity,
                              height: 182,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                        ),
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data['name'] ?? '',
                            style: AppTypography.body14Medium.copyWith(
                              color: AppColors.neutral100,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (data['rating'] != null) ...[
                          Row(
                            children: [
                              Image.asset('assets/icons/Solid/png/star.png',
                                  width: 18,
                                  height: 18,
                                  color: AppColors.warning40),
                              const SizedBox(width: 4),
                              Text('${data['rating']}',
                                  style: AppTypography.body14SemiBold
                                      .copyWith(color: AppColors.neutral100)),
                            ],
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['location'] ?? '',
                      style: AppTypography.caption12Regular.copyWith(
                        color: AppColors.neutral60,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (data['hits'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '${data['hits']}명이 확인 중',
                          style: AppTypography.subtitle16SemiBold.copyWith(
                            color: AppColors.indigo60,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 13,
          right: 27,
          child: GestureDetector(
            onTap: () async {
              if (!widget.isLoggedIn) {
                final result = await LoginRequiredDialog.show(context);
                if (result == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const MainScreen(initialIndex: 2, isLoggedIn: false),
                    ),
                  );
                }
                return;
              }
              await FirebaseFirestore.instance
                  .collection('influencers')
                  .doc(docId)
                  .update({'isLiked': !isLiked});
            },
            child: Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              child: Image.asset(
                !widget.isLoggedIn
                    ? 'assets/icons/Outline/png/heartx.png'
                    : (isLiked
                        ? 'assets/icons/Solid/png/heart-1.png'
                        : 'assets/icons/Outline/png/heartx.png'),
                width: 26,
                height: 26,
                fit: BoxFit.contain,
                color: AppColors.error60,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContentBanner() {
    final List<Map<String, String>> _bannerData = [
      {
        'title': '✅ 공항 입국 절차 총정리 5가지',
        'description': '여행 전 꼭 알아야 할 입국 절차 꿀팁!',
        'url': 'https://blog.naver.com/tripblock/223904840422',
        'image':
            'https://www.airport.kr/sites/co_ko/images/sub/constr-step1-img3.jpg',
      },
      {
        'title': '✨파리 3박 4일 알짜 일정표',
        'description': '자유여행자 추천! ',
        'url': 'https://blog.naver.com/tripblock/223904837267',
        'image':
            'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': ' 여행지 와이파이·유심 추천 가이드',
        'description': '해외에서 데이터 걱정 끝! ',
        'url': 'https://blog.naver.com/tripblock/223904834339',
        'image': 'https://img.hankyung.com/photo/202009/99.14567735.1.jpg',
      },
      {
        'title': '여행 가이드 TOP 5 🏆',
        'description': '도시/국가별 여행 꿀팁 총정리',
        'url': 'https://blog.naver.com/tripblock/223904821676',
        'image':
            'https://image.fnnews.com/resource/media/image/2020/07/14/202007140905305099_l.jpg',
      },
    ];

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _bannerPageController,
            onPageChanged: (index) {
              setState(() {
                _currentBannerPage = index;
              });
            },
            itemCount: _bannerData.length,
            itemBuilder: (context, index) {
              final banner = _bannerData[index];
              return GestureDetector(
                onTap: () async {
                  final url = banner['url'];
                  if (url != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(
                          url: url,
                          title: banner['title'],
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          banner['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              banner['title']!,
                              style: AppTypography.subtitle20Bold.copyWith(
                                color: AppColors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              banner['description']!,
                              style: AppTypography.body14Regular.copyWith(
                                color: AppColors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _bannerData.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentBannerPage == index
                    ? AppColors.indigo60
                    : AppColors.neutral30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginRequiredDialog extends StatelessWidget {
  const LoginRequiredDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const LoginRequiredDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.indigo10,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(16),
              child: const Icon(Icons.lock_outline,
                  size: 40, color: AppColors.indigo60),
            ),
            const SizedBox(height: 20),
            Text(
              '로그인이 필요합니다',
              style: AppTypography.subtitle20Bold.copyWith(
                color: AppColors.neutral100,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '찜 기능은 로그인 후 이용하실 수 있습니다.',
              style: AppTypography.body14Regular.copyWith(
                color: AppColors.neutral60,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.neutral60,
                      side: const BorderSide(color: AppColors.neutral30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('취소', style: AppTypography.body14Medium),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.indigo60,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                    child: const Text('로그인하러 가기',
                        style: AppTypography.body14Medium),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
