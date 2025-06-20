import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/purchased_packages_card.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/tab_bar_selector.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_navbar.dart';
import 'package:personalized_travel_recommendations/presentation/pages/main_screen.dart';
import 'package:personalized_travel_recommendations/data/datasources/travel_packages_data_source.dart';

class PurchasedTripsScreen extends StatefulWidget {
  final ScrollController? scrollController;
  const PurchasedTripsScreen({super.key, this.scrollController});

  @override
  State<PurchasedTripsScreen> createState() => _PurchasedTripsScreenState();
}

class _PurchasedTripsScreenState extends State<PurchasedTripsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['출발 전', '다녀온 여행', '취소'];

  late List<Map<String, dynamic>> upcomingTrips;
  late List<Map<String, dynamic>> pastTrips;
  late List<Map<String, dynamic>> canceledTrips;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {});
    });

    final allTrips = TravelPackagesDataSource.getAllPackages()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    upcomingTrips = allTrips
        .where((e) => e['name'] == '일본 벚꽃 투어')
        .toList();
    pastTrips = [];
    canceledTrips = [];
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
                child: Text('구매 상품', style: AppTypography.title24Bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TabBarSelector(
                tabs: _tabs,
                selectedIndex: _tabController.index,
                onTap: (index) => setState(() => _tabController.index = index),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildList(upcomingTrips),
                  _buildList(pastTrips),
                  _buildList(canceledTrips),
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

  Widget _buildList(List<Map<String, dynamic>> sourceList) {
    if (sourceList.isEmpty) {
      return const Center(child: Text('해당 패키지가 없습니다.'));
    }
    return ListView.separated(
      controller: widget.scrollController,
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
      itemCount: sourceList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = sourceList[index];
        return Align(
          alignment: Alignment.center,
          child: TripCard(
            imageUrl: item['image'],
            title: item['name'],
            subtitle: item['location'],
            departureDate: '2025.07.01 ~ 2025.07.03',
            tags: const ['#친구와', '#1개 도시', '#맛집 투어'],
            isAssetImage: false,
            onTap: () {

            },
          ),
        );
      },
    );
  }
}

class PurchasedTripsModalWrapper extends StatelessWidget {
  const PurchasedTripsModalWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: PurchasedTripsScreen(scrollController: scrollController),
        );
      },
    );
  }
}