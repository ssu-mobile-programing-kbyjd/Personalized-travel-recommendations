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

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

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
                const Text(
                  '당신은 지금,',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
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
            color: Color(0xFF0F1A2A),
          ),
          const SizedBox(width: 4),
          Text(
            _selectedCountry != null ? _selectedCountry! : '위치를 선택해주세요',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _selectedCountry != null
                  ? Color(0xFF0F1A2A)
                  : Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: Color(0xFF64748B),
          ),
        ],
      ),
    );
  }

  void _showLocationSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        String? tempContinent = _selectedContinent;
        String? tempCountry = _selectedCountry;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 대륙 선택
                  DropdownButton<String>(
                    value: tempContinent,
                    hint: const Text('대륙 선택'),
                    isExpanded: true,
                    items: _locationData.keys.map((continent) {
                      return DropdownMenuItem(
                        value: continent,
                        child: Text(continent),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setModalState(() {
                        tempContinent = value;
                        tempCountry = null;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  // 국가 선택
                  if (tempContinent != null)
                    DropdownButton<String>(
                      value: tempCountry,
                      hint: const Text('국가 선택'),
                      isExpanded: true,
                      items: _locationData[tempContinent!]!.map((country) {
                        return DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setModalState(() {
                          tempCountry = value;
                        });
                      },
                    ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedContinent = tempContinent;
                        _selectedCountry = tempCountry;
                        _selectedCategoryIndex = 0;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('선택 완료'),
                  ),
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
      margin: const EdgeInsets.all(16),
      height: 37,
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
              margin:
                  EdgeInsets.only(right: index < cities.length - 1 ? 16 : 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4032DC) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4032DC)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_city,
                    size: 20,
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    city,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          isSelected ? Colors.white : const Color(0xFF64748B),
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
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '요즘 뜨는 여행지',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F1A2A),
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
                child: const Text(
                  '전체 보기',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4C4DDC),
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
                          return _buildDestinationCardFromFirestore(
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

  Widget _buildDestinationCardFromFirestore(
      Map<String, dynamic> data, String docId) {
    final isLiked = data['isLiked'] == true;
    return Stack(
      children: [
        Container(
          width: 257,
          margin: const EdgeInsets.only(bottom: 30, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
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
                        child: Image.network(
                          data['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey[200]),
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
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0F1A2A),
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
                                  color: const Color(0xFFFFC107)),
                              SizedBox(width: 4),
                              Text('${data['rating']}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0F1A2A))),
                            ],
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['location'] ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (data['hits'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '${data['hits']}명이 확인 중',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4032DC),
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
                isLiked
                    ? 'assets/icons/Solid/png/heart-1.png'
                    : 'assets/icons/Outline/png/heartx.png',
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
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '최근 업데이트 된 여행 패키지',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F1A2A),
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
                child: const Text(
                  '전체 보기',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4C4DDC),
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
            color: Colors.white,
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
                        child: Image.network(
                          data['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey[200]),
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
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0F1A2A),
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
                                  color: const Color(0xFFFFC107)),
                              SizedBox(width: 4),
                              Text('${data['rating']}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0F1A2A))),
                            ],
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['location'] ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (data['hits'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '${data['hits']}명이 확인 중',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4032DC),
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
                isLiked
                    ? 'assets/icons/Solid/png/heart-1.png'
                    : 'assets/icons/Outline/png/heartx.png',
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
              const Text(
                '맞춤 트립인플루언서',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F1A2A),
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
                child: const Text(
                  '전체 보기',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4C4DDC),
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
            color: Colors.white,
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
                        child: Image.network(
                          data['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey[200]),
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
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0F1A2A),
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
                                  color: const Color(0xFFFFC107)),
                              SizedBox(width: 4),
                              Text('${data['rating']}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0F1A2A))),
                            ],
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['location'] ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (data['hits'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '${data['hits']}명이 확인 중',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4032DC),
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
                isLiked
                    ? 'assets/icons/Solid/png/heart-1.png'
                    : 'assets/icons/Outline/png/heartx.png',
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
        'image': 'assets/images/SagradaFamilia.png',
        'title': '스페인 여행 특가',
        'description': '사그라다 파밀리아와 함께하는 바르셀로나 투어',
      },
      {
        'image': 'assets/images/TokyoRestaurants.png',
        'title': '도쿄 맛집 투어',
        'description': '현지 맛집 추천 및 가이드 투어',
      },
      {
        'image': 'assets/images/CasaMila.png',
        'title': '가우디 건축 투어',
        'description': '카사밀라와 함께하는 건축 여행',
      },
    ];

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: GestureDetector(
            onTap: () async {
              await uploadDummyData();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('더미 데이터가 업로드되었습니다.')),
                );
              }
            },
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
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(banner['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banner['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          banner['description']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
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
                    ? const Color(0xFF4032DC)
                    : const Color(0xFFE2E8F0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
