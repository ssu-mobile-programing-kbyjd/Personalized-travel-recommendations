import 'package:flutter/material.dart';
import '../../../domain/usecases/trending_destinations_usecase.dart';
import '../../../presentation/widgets/common/app_header.dart';
import '../../../presentation/widgets/common/search_bar_widget.dart';
import '../../../presentation/widgets/common/category_filter_widget.dart';
import '../../../presentation/utils/category_filter_helper.dart';
import '../../../presentation/widgets/trending_destinations/trending_destination_card.dart';
import '../../../data/models/trending_destination_model.dart';

class TrendingDestinationsScreen extends StatefulWidget {
  const TrendingDestinationsScreen({super.key});

  @override
  State<TrendingDestinationsScreen> createState() => _TrendingDestinationsScreenState();
}

class _TrendingDestinationsScreenState extends State<TrendingDestinationsScreen> {
  final TrendingDestinationsUseCase _useCase = TrendingDestinationsUseCase();
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';



  @override
  Widget build(BuildContext context) {
    final categories = CategoryFilterHelper.createCategoryFilters(_useCase.getCategories());
    final destinations = _useCase
        .getDestinationsByCategoryIndex(_selectedCategoryIndex)
        .where((destination) => destination.name.contains(_searchQuery) || destination.location.contains(_searchQuery))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(showBackButton: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SearchBarWidget(
                hintText: '검색어를 입력하세요',
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            CategoryFilterWidget(
              categories: categories,
              selectedIndex: _selectedCategoryIndex,
              onCategorySelected: (index) {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '요즘 뜨는 여행지',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F1A2A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: destinations.isEmpty
                          ? const Center(child: Text('해당 카테고리에 여행지가 없습니다.'))
                          : ListView.builder(
                              itemCount: destinations.length,
                              itemBuilder: (context, index) => TrendingDestinationCard(destination: destinations[index]),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
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