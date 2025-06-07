import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/widget/favorite_card.dart';
import 'package:personalized_travel_recommendations/widget/tab_bar_selector.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = ['여행지', '패키지', '컨텐츠'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('찜한 목록', style: AppTypography.subtitle20Bold),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBarSelector(
            tabs: _tabs,
            selectedIndex: _tabController.index,
            onTap: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildListView('여행지'),
          _buildListView('패키지'),
          _buildListView('컨텐츠'),
        ],
      ),
    );
  }

  Widget _buildListView(String type) {
    final List<Map<String, dynamic>> items;

    if (type == '여행지') {
      items = [
        {
          'imageUrl': 'assets/images/SagradaFamilia.png',
          'title': '사그라다 파밀리아',
          'subtitle': '바르셀로나 어쩌구',
          'rating': 5.0,
          'tags': <String>[],
        },
        {
          'imageUrl': 'assets/images/CasaMila.png',
          'title': '카사 밀라',
          'subtitle': 'Northern Territory 0872, Australia',
          'rating': 5.0,
          'tags': <String>[],
        },
      ];
    } else if (type == '패키지') {
      items = [
        {
          'imageUrl': 'assets/images/TokyoRestaurants.png',
          'title': '도쿄 10대 맛집 뿌수기',
          'subtitle': '일본\n2박 3일',
          'rating': 0.0,
          'tags': <String>['#친구와', '#힐링 여행', '#맛집 투어'],
        },
        {
          'imageUrl': 'assets/images/TokyoRestaurants.png',
          'title': '스페인 도시 뿌수기',
          'subtitle': '7박 9일',
          'rating': 0.0,
          'tags': <String>['#친구와', '#3개 도시', '#디저트 투어'],
        },
      ];
    } else {
      items = [
        {
          'imageUrl': 'assets/images/contents.png',
          'title': '도시 및 국가별 여행 가이드',
          'subtitle': '여행 정보',
          'rating': 0.0,
          'tags': <String>[],
        },
        {
          'imageUrl': 'assets/images/contents.png',
          'title': '도시 및 국가별 여행 가이드',
          'subtitle': '여행 정보',
          'rating': 0.0,
          'tags': <String>[],
        },
      ];
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => FavoriteCard(
        imageUrl: items[index]['imageUrl'],
        title: items[index]['title'],
        subtitle: items[index]['subtitle'],
        rating: items[index]['rating'],
        tags: List<String>.from(items[index]['tags'] ?? []),
        isAssetImage: true,
        isPackage: type == '패키지',
        isContent: type == '컨텐츠',
      ),
    );
  }
}
