import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/theme/app_text_styles.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  final List<Map<String, String>> notices = const [
    {
      'title': '[공지] 서비스 향상을 위한 여행 이용약관이 곧 변경될 예정입니다.',
      'date': '2025.06.02',
    },
    {
      'title': '[공지] 해외 여행 시 필수! 여행자 보험 가이드가 업데이트되었습니다.',
      'date': '2025.05.28',
    },
    {
      'title': '[공지] 개인정보 보호를 위한 보안 시스템이 강화되었습니다.',
      'date': '2025.05.27',
    },
    {
      'title': '[공지] 예약 시스템 점검 안내 (5/21 수 23:30 ~ 5/22 목 01:00)',
      'date': '2025.05.20',
    },
    {
      'title': '[공지] 위치기반 추천 기능의 정확도를 개선했습니다.',
      'date': '2025.04.25',
    },
    {
      'title': '[공지] 새로운 여행 패키지 상품이 출시되었습니다. 지금 확인해보세요!',
      'date': '2025.04.16',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('공지사항', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: notices.length,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const Divider(color: AppColors.neutral20),
        itemBuilder: (context, index) {
          final item = notices[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['title']!,
                style: AppTypography.body16Medium.copyWith(color: AppColors.neutral90),
              ),
              const SizedBox(height: 4),
              Text(
                item['date']!,
                style: AppTypography.caption12Regular.copyWith(color: AppColors.neutral50),
              ),
            ],
          );
        },
      ),
    );
  }
}
