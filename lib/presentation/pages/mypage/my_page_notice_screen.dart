import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_navbar.dart';
import 'package:personalized_travel_recommendations/presentation/pages/main_screen.dart'; // MainScreen 경로에 맞게 수정

class MyPageNoticeScreen extends StatelessWidget {
  const MyPageNoticeScreen({super.key});

  final List<Map<String, String>> _notices = const [
    {
      "title": "[공지] 여름 인기 여행지 추천 기능이 업데이트되었습니다.",
      "date": "2025.06.12"
    },
    {
      "title": "[공지] 항공권 예약 시스템 점검 안내 (6/15 새벽 2시)",
      "date": "2025.06.10"
    },
    {
      "title": "[공지] 마이페이지 UI가 새롭게 변경되었어요!",
      "date": "2025.06.05"
    },
    {
      "title": "[공지] 여행지 맞춤 추천 알고리즘이 향상되었습니다.",
      "date": "2025.06.01"
    },
    {
      "title": "[공지] 앱 안정화 및 성능 개선 업데이트 안내",
      "date": "2025.05.25"
    },
    {
      "title": "[공지] 커뮤니티 기능이 새롭게 오픈되었어요!",
      "date": "2025.05.18"
    },
  ];

  void _onNavTap(BuildContext context, int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MainScreen(initialIndex: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/Solid/png/cheveron-left.png',
            width: 24,
            height: 24,
            color: AppColors.neutral60,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '공지사항',
          style: AppTypography.subtitle20Bold,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _notices.length,
        separatorBuilder: (_, __) =>
        const Divider(color: AppColors.neutral20),
        itemBuilder: (context, index) {
          final notice = _notices[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notice['title'] ?? '',
                style: AppTypography.body16Regular
                    .copyWith(color: AppColors.neutral90),
              ),
              const SizedBox(height: 6),
              Text(
                notice['date'] ?? '',
                style: AppTypography.caption12Regular
                    .copyWith(color: AppColors.neutral40),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2, // 디자인상 My Page가 강조됨
        onTap: (index) => _onNavTap(context, index),
      ),
    );
  }
}
