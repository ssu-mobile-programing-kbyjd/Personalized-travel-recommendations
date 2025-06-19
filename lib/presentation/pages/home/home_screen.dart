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
              if (!widget.isLoggedIn) {
                final result = await LoginRequiredDialog.show(context);
                if (result == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MainScreen(initialIndex: 2, isLoggedIn: false),
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
              if (!widget.isLoggedIn) {
                final result = await LoginRequiredDialog.show(context);
                if (result == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MainScreen(initialIndex: 2, isLoggedIn: false),
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
              if (!widget.isLoggedIn) {
                final result = await LoginRequiredDialog.show(context);
                if (result == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MainScreen(initialIndex: 2, isLoggedIn: false),
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
        'title': ' 🌍 여행지 와이파이·유심 추천 가이드',
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
                    image: DecorationImage(
                        image: NetworkImage(banner['image']!),
                        fit: BoxFit.cover),
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        banner['description']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
              decoration: BoxDecoration(
                color: const Color(0xFFE0E7FF),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(16),
              child: const Icon(Icons.lock_outline,
                  size: 40, color: Color(0xFF4032DC)),
            ),
            const SizedBox(height: 20),
            const Text(
              '로그인이 필요합니다',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '찜 기능은 로그인 후 이용하실 수 있습니다.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
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
                      foregroundColor: const Color(0xFF64748B),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('취소'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4032DC),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                    child: const Text('로그인하러 가기'),
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
