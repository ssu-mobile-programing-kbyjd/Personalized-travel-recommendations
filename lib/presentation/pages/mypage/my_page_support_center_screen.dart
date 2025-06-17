import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';

class SupportCenterScreen extends StatelessWidget {
  const SupportCenterScreen({super.key});

  final List<Map<String, dynamic>> items = const [
    {'label': '여행 일정 변경/취소 규정이 궁금해요.', 'icon': Icons.info_outline},
    {'label': '여행 일정을 변경하고 싶어요.', 'icon': Icons.calendar_today_outlined},
    {'label': '예약을 취소하고 싶어요.', 'icon': Icons.cancel_outlined},
    {'label': '취소 신청이 잘 되었는지 궁금해요.', 'icon': Icons.hourglass_empty},
    {'label': '탑승 정보(항공/기차 등)를 수정하고 싶어요.', 'icon': Icons.airplane_ticket_outlined},
    {'label': '패키지/티켓을 취소하고 싶어요.', 'icon': Icons.receipt_long},
    {'label': '픽업/샌딩 관련 문의가 있어요.', 'icon': Icons.directions_car},
    {'label': '숙소에 요청할 것이 있어요.', 'icon': Icons.hotel},
    {'label': '채팅 상담', 'icon': Icons.chat},
    {'label': '전화 상담 요청', 'icon': Icons.call},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
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
        title: const Text('고객센터', style: AppTypography.subtitle20Bold),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(items[index]['icon'], color: AppColors.neutral60),
            title: Text(
              items[index]['label'],
              style: AppTypography.body16Regular.copyWith(color: AppColors.neutral90),
            ),
            trailing: const Icon(Icons.chevron_right, color: AppColors.neutral40),
            onTap: () {
              // 각 항목 클릭 시 처리
            },
          );
        },
      ),
    );
  }
}
