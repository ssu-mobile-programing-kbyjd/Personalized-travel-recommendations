import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/theme/app_icons.dart';
import 'package:personalized_travel_recommendations/widget/custom_button.dart';

class TravelCalendarScreen extends StatelessWidget {
  const TravelCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('여행 일정'),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 타이틀
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '나의 여행 캘린더',
                    style: AppTypography.title24Bold,
                  ),
                  Icon(Icons.calendar_today, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 24),
              // 달력 예시 (간단하게 1주일만 표시)
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F8FB),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('S',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('M',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('T',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('W',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('T',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('F',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('S',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('26'),
                        Text('27'),
                        Text('28'),
                        Text('29'),
                        Text('30'),
                        Text('31'),
                        Text('1'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // 이전 여행 정보
              const Text(
                '나의 이전 여행',
                style: AppTypography.subtitle18Bold,
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F8FB),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://placehold.co/75x75",
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('도쿄 10대 맛집 뿌수기',
                              style: AppTypography.subtitle18Bold),
                          const Text('일본 도쿄',
                              style: AppTypography.body14Regular),
                          const Text('2025. 03. 18 ~ 2025. 03. 20',
                              style: AppTypography.body14Regular),
                          Text('2박 3일',
                              style: AppTypography.body14Medium
                                  .copyWith(color: AppColors.indigo60)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // 하단 버튼
              Center(
                child: CustomButton(
                  text: '여행 추가하기',
                  onPressed: () {},
                  color: AppColors.indigo60,
                  textColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
