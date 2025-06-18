import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/favorite_card.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/tab_bar_selector.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_navbar.dart';
import 'package:personalized_travel_recommendations/presentation/pages/main_screen.dart';
import 'package:personalized_travel_recommendations/data/datasources/travel_packages_data_source.dart';
import 'package:personalized_travel_recommendations/data/datasources/location_data_source.dart';
import 'package:personalized_travel_recommendations/data/datasources/destinations_dummy_data.dart';

class WishlistScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const WishlistScreen({super.key, this.scrollController});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['여행지', '패키지', '컨텐츠'];

  late List<Map<String, dynamic>> destinationState;
  late List<Map<String, dynamic>> packageState;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        setState(() {}); // 상단 탭 상태 갱신
      }
    });

    destinationState = destinationsDummyData
        .map((item) => Map<String, dynamic>.from(item))
        .toList();

    packageState = TravelPackagesDataSource.getAllPackages()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MainScreen(initialIndex: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.neutral40,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('찜한 목록', style: AppTypography.title24Bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TabBarSelector(
                tabs: _tabs,
                selectedIndex: _tabController.index,
                onTap: (index) {
                  setState(() {
                    _tabController.index = index;

                    // 필터링: 찜이 아닌 항목 제거
                    if (_tabs[index] == '여행지') {
                      destinationState = destinationState.where((item) => item['isLiked'] == true).toList();
                    } else if (_tabs[index] == '패키지') {
                      packageState = packageState.where((item) => item['isLiked'] == true).toList();
                    }
                  });
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildListView('여행지'),
                  _buildListView('패키지'),
                  _buildListView('컨텐츠'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildListView(String type) {
    if (type == '여행지') {
      return ListView.separated(
        controller: widget.scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: destinationState.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final destination = destinationState[index];
          //if (destination['isLiked'] != true) return const SizedBox.shrink();
          return FavoriteCard(
            imageUrl: destination['image'],
            title: destination['name'],
            subtitle: destination['location'],
            rating: destination['rating'] ?? 0.0,
            tags: const [],
            isAssetImage: false,
            isPackage: false,
            isContent: false,
            onHeartTap: () {
              setState(() {
                destination['isLiked'] = false;
              });
            },
            isLiked: destination['isLiked'] ?? true,
          );
        },
      );
    } else if (type == '패키지') {
      return ListView.separated(
        controller: widget.scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: packageState.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = packageState[index];
          //if (item['isLiked'] != true) return const SizedBox.shrink();
          return FavoriteCard(
            imageUrl: 'assets/images/TokyoRestaurants.png',
            title: item['name'],
            subtitle: '${item['location']}\n${item['duration']}',
            rating: double.tryParse(item['rating']) ?? 0.0,
            tags: List<String>.from(item['tags'] ?? []),
            isAssetImage: true,
            isPackage: true,
            isContent: false,
            isLiked: item['isLiked'] ?? false,
            onHeartTap: () {
              setState(() {
                item['isLiked'] = false;
              });
            },
          );
        },
      );
    } else {
      final allCountries = LocationDataSource.locationData.values
          .expand((countryMap) => countryMap.keys)
          .toSet()
          .toList();

      final items = allCountries.map((country) =>
      {
        'imageUrl': 'assets/images/SagradaFamilia.png',
        'title': '$country 여행 가이드',
        'subtitle': '$country 여행 가이드',
        'rating': 0.0,
        'tags': <String>[]
      }).toList();

      return ListView.separated(
        controller: widget.scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          final bool isLiked = item['isLiked'] == true;

          return FavoriteCard(
            imageUrl: item['imageUrl']?.toString() ?? '',
            title: item['title']?.toString() ?? '',
            subtitle: item['subtitle']?.toString() ?? '',
            rating: double.tryParse(item['rating']?.toString() ?? '0.0') ?? 0.0,
            tags: (item['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
            isAssetImage: true,
            isPackage: type == '패키지',
            isContent: type == '컨텐츠',
            isLiked: isLiked,
            onHeartTap: () {
              setState(() {
                item['isLiked'] = !isLiked;
              });
            },
          );
        },
      );
    }
  }
}
