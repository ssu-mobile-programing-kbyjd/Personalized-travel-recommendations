import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/favorite_card.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/tab_bar_selector.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_navbar.dart';
import 'package:personalized_travel_recommendations/presentation/pages/main_screen.dart';
import 'package:personalized_travel_recommendations/data/datasources/travel_packages_data_source.dart';
import 'package:personalized_travel_recommendations/data/datasources/destinations_dummy_data.dart';
import 'package:personalized_travel_recommendations/data/datasources/travel_content_data_source.dart';

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

  late List<Map<String, dynamic>> destinationMaster;
  late List<Map<String, dynamic>> packageMaster;
  late List<Map<String, dynamic>> contentMaster;

  late List<Map<String, dynamic>> destinationState;
  late List<Map<String, dynamic>> packageState;
  late List<Map<String, dynamic>> contentState;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    destinationMaster = destinationsDummyData
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    packageMaster = TravelPackagesDataSource.getAllPackages()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    contentMaster = TravelContentDataSource.getAllContents()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    _updateFilteredStates();

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _updateFilteredStates();
      }
    });
  }

  void _updateFilteredStates() {
    setState(() {
      destinationState =
          destinationMaster.where((e) => e['isLiked'] == true).toList();
      packageState =
          packageMaster.where((e) => e['isLiked'] == true).toList();
      contentState =
          contentMaster.where((e) => e['isLiked'] == true).toList();
    });
  }

  void _onNavTap(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MainScreen(initialIndex: index)),
    );
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
                  _tabController.index = index;
                  _updateFilteredStates();
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
      if (destinationState.isEmpty) {
        return const Center(child: Text('찜한 여행지가 없습니다.'));
      }
      return _buildList(destinationState, isPackage: false, isContent: false);
    } else if (type == '패키지') {
      if (packageState.isEmpty) {
        return const Center(child: Text('찜한 패키지가 없습니다.'));
      }
      return _buildList(packageState, isPackage: true, isContent: false);
    } else {
      if (contentState.isEmpty) {
        return const Center(child: Text('찜한 컨텐츠가 없습니다.'));
      }
      return _buildList(contentState, isPackage: false, isContent: true);
    }
  }

  Widget _buildList(List<Map<String, dynamic>> sourceList,
      {required bool isPackage, required bool isContent}) {
    return ListView.separated(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: sourceList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = sourceList[index];
        //if (isPackage && item['isLiked'] != true) return const SizedBox.shrink();

        return FavoriteCard(
          imageUrl: isPackage
              ? 'assets/images/TokyoRestaurants.png'
              : item['image'] ?? '',
          title: isPackage ? item['name'] : item['title'] ?? item['name'],
          subtitle: isPackage
              ? '${item['location']}\n${item['duration']}'
              : '${item['location']} 여행 정보',
          rating: isPackage
              ? double.tryParse(item['rating']) ?? 0.0
              : item['rating'] ?? 0.0,
          tags: List<String>.from(item['tags'] ?? []),
          isAssetImage: isPackage,
          isPackage: isPackage,
          isContent: isContent,
          isLiked: item['isLiked'] ?? false,
          onHeartTap: () {
            setState(() {
              item['isLiked'] = !(item['isLiked'] ?? false);
              final indexInMaster = packageMaster.indexWhere((e) => e['id'] == item['id']);
              if (indexInMaster != -1) {
                packageMaster[indexInMaster]['isLiked'] = item['isLiked'];
              }
            });
          },
        );
      },
    );
  }
}
