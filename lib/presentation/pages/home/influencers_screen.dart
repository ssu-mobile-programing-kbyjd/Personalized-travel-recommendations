import 'package:flutter/material.dart';
import '../../../domain/usecases/influencers_usecase.dart';
import '../../../presentation/widgets/common/app_header.dart';
import '../../../presentation/widgets/common/search_bar_widget.dart';
import '../../../presentation/widgets/common/category_filter_widget.dart';
import '../../../presentation/utils/category_filter_helper.dart';
import '../../../presentation/widgets/influencers/influencer_card.dart';
import '../../../data/models/influencer_model.dart';

class InfluencersScreen extends StatefulWidget {
  const InfluencersScreen({super.key});

  @override
  State<InfluencersScreen> createState() => _InfluencersScreenState();
}

class _InfluencersScreenState extends State<InfluencersScreen> {
  final InfluencersUseCase _useCase = InfluencersUseCase();
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';



  @override
  Widget build(BuildContext context) {
    final categories = CategoryFilterHelper.createCategoryFilters(_useCase.getCategories());
    final influencers = _useCase
        .getInfluencersByCategoryIndex(_selectedCategoryIndex)
        .where((influencer) => influencer.name.contains(_searchQuery) || influencer.location.contains(_searchQuery))
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
                      '맞춤 트립인플루언서',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF101010),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: influencers.isEmpty
                          ? const Center(child: Text('해당 카테고리에 인플루언서가 없습니다.'))
                          : ListView.builder(
                              itemCount: influencers.length,
                              itemBuilder: (context, index) => InfluencerCard(influencer: influencers[index]),
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