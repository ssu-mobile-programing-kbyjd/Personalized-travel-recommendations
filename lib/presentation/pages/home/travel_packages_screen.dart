import 'package:flutter/material.dart';
import '../../../data/models/travel_package_model.dart';
import '../../../domain/usecases/travel_packages_usecase.dart';
import '../../widgets/common/app_header.dart';
import '../../widgets/common/search_bar_widget.dart';
import '../../widgets/common/category_filter_widget.dart';
import '../../utils/category_filter_helper.dart';
import '../../widgets/travel_packages/travel_package_card.dart';

class TravelPackagesScreen extends StatefulWidget {
  const TravelPackagesScreen({super.key});

  @override
  State<TravelPackagesScreen> createState() => _TravelPackagesScreenState();
}

class _TravelPackagesScreenState extends State<TravelPackagesScreen> {
  int _selectedCategoryIndex = 0;
  List<TravelPackageModel> _packages = [];
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _categories = TravelPackagesUseCase.getCategoryFilters();
    _loadPackages();
  }

  void _loadPackages() {
    if (_selectedCategoryIndex < _categories.length) {
      final selectedCategory = _categories[_selectedCategoryIndex]['name'] as String;
      _packages = TravelPackagesUseCase.getPackagesByCategory(selectedCategory);
    }
    setState(() {});
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
    _loadPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            const AppHeader(),
            
            // 검색바
            const SearchBarWidget(),
            
            // 카테고리 필터
            CategoryFilterWidget(
              categories: _categories,
              selectedIndex: _selectedCategoryIndex,
              onCategorySelected: _onCategorySelected,
            ),
            
            // 패키지 리스트
            Expanded(
              child: _buildPackageList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildPackageList() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '최근 업데이트 된 여행 패키지',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F1A2A),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _packages.length,
              itemBuilder: (context, index) => TravelPackageCard(
                package: _packages[index],
                onTap: () => _onPackageTap(_packages[index]),
                onBookingTap: () => _onBookingTap(_packages[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPackageTap(TravelPackageModel package) {
    // 패키지 상세 화면으로 이동
    print('패키지 탭: ${package.name}');
  }

  void _onBookingTap(TravelPackageModel package) {
    // 예약 화면으로 이동
    print('예약 탭: ${package.name}');
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.9),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(24),
        height: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8FC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: 24,
                    color: Color(0xFF4032DC),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4032DC),
                    ),
                  ),
                ],
              ),
            ),
            // Calendar
            const Icon(
              Icons.calendar_month_outlined,
              size: 24,
              color: Color(0xFF64748B),
            ),
            // Globe
            const Icon(
              Icons.language_outlined,
              size: 24,
              color: Color(0xFF64748B),
            ),
            // Profile
            const Icon(
              Icons.person_outline,
              size: 24,
              color: Color(0xFF64748B),
            ),
          ],
        ),
      ),
    );
  }
} 