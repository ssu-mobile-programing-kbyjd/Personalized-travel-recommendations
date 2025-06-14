import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:personalized_travel_recommendations/domain/entities/location_entity.dart';
import 'package:personalized_travel_recommendations/presentation/pages/home/widgets/location_selector_widget.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/common/section_header_widget.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/common/travel_card_widget.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/common/category_filter_widget.dart';
import 'package:personalized_travel_recommendations/presentation/utils/category_filter_helper.dart';
import 'package:personalized_travel_recommendations/presentation/pages/home/trending_destinations_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/home/travel_packages_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/home/influencers_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final PageController _bannerPageController = PageController();
  int _currentBannerPage = 0;
  int _selectedCategoryIndex = 0;
  LocationEntity? _currentLocation;

  @override
  void dispose() {
    _bannerPageController.dispose();
    super.dispose();
  }

  void _onLocationChanged(LocationEntity location) {
    setState(() {
      _currentLocation = location;
    });
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
              CategoryFilterWidget(
                categories: CategoryFilterHelper.createCategoryFilters(
                  CategoryFilterHelper.getHomeCategoryNames(),
                ),
                selectedIndex: _selectedCategoryIndex,
                onCategorySelected: (index) {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
              ),
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
          Container(
            width: 33,
            height: 49,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 8),
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
                LocationSelectorWidget(
                  onLocationChanged: _onLocationChanged,
                ),
              ],
            ),
          ),
          _buildNotificationButton(),
        ],
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.notifications_outlined,
              size: 24,
              color: Color(0xFF0F1A2A),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFCF4920),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContentBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 200,
      child: PageView.builder(
        controller: _bannerPageController,
        onPageChanged: (index) {
          setState(() {
            _currentBannerPage = index;
          });
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '배너 ${index + 1}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingDestinations() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          SectionHeader(
            title: '요즘 뜨는 여행지',
            actionText: '전체 보기',
            onActionPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TrendingDestinationsScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: index < 4 ? 16 : 0),
                  child: TravelCard(
                    name: '여행지 ${index + 1}',
                    location: '위치 정보',
                    rating: '4.${5 + index}',
                    status: '인기 급상승',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPackages() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          SectionHeader(
            title: '최근 업데이트 된 여행 패키지',
            actionText: '전체 보기',
            onActionPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TravelPackagesScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: index < 4 ? 16 : 0),
                  child: TravelCard(
                    name: '패키지 ${index + 1}',
                    location: '여행지 정보',
                    rating: '4.${7 + index}',
                    status: '${5 + index}명이 예약 중',
                    price: '₩${999 + index * 100},000',
                    originalPrice: '₩${1199 + index * 100},000',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomInfluencers() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          SectionHeader(
            title: '맞춤 트립인플루언서',
            actionText: '전체 보기',
            onActionPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfluencersScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: index < 4 ? 16 : 0),
                  child: TravelCard(
                    name: '인플루언서 ${index + 1}',
                    location: '전문 지역',
                    rating: '4.${8 + index}',
                    status: '상담 가능',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
