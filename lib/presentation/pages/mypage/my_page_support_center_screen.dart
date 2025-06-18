import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_navbar.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/settings_list_item.dart';
import 'package:personalized_travel_recommendations/presentation/pages/main_screen.dart';

class SupportCenterScreen extends StatelessWidget {
  const SupportCenterScreen({super.key});

  final List<Map<String, String>> inquiryItems = const [
    {'emoji': '💰', 'label': '항공권 변경/취소 수수료 규정이 궁금해요.'},
    {'emoji': '✈️', 'label': '항공권 일정을 변경하고 싶어요.'},
    {'emoji': '❌', 'label': '항공권을 취소하고 싶어요.'},
    {'emoji': '⏳', 'label': '항공권 취소 신청이 잘 되었는지 궁금해요.'},
    {'emoji': '📝', 'label': '항공권 탑승자 정보를 변경하고 싶어요.'},
    {'emoji': '🎫', 'label': '투어/티켓을 취소하고 싶어요.'},
    {'emoji': '🚗', 'label': '투어의 픽업/샌딩 관련 문의가 있어요.'},
    {'emoji': '🏨', 'label': '예약한 숙소에 요청할 것이 있어요.'},
  ];

  final List<Map<String, String>> supportOptions = const [
    {
      'iconPath': 'assets/icons/Solid/png/chat.png',
      'label': '채팅 상담'
    },
    {
      'iconPath': 'assets/icons/Solid/png/phone.png',
      'label': '항공 전화 상담'
    },
    {
      'iconPath': 'assets/icons/Solid/png/phone.png',
      'label': '항공 외 전화 상담'
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
      body: Column(
        children: [
          // 🔹 상단 제목 (AppBar 대신)
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 66, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '문의하기',
                style: AppTypography.title24Bold.copyWith(color: AppColors.neutral90),
              ),
            ),
          ),

          // 🔹 상단 공지
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
            color: AppColors.neutral10,
            child: Row(
              children: [
                Text(
                  '공지 ',
                  style: AppTypography.caption12Regular.copyWith(
                    color: AppColors.indigo80,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '항공권 취소/변경 접수 시간 변경 안내',
                    style: AppTypography.caption12Regular.copyWith(
                      color: AppColors.neutral70,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 🔹 전체 리스트
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    '무엇을 도와드릴까요?',
                    style: AppTypography.subtitle18Bold.copyWith(color: AppColors.neutral90),
                  ),
                ),
                ...inquiryItems.map((item) {
                  return SettingsListItem(
                    leadingIcon: Text(item['emoji']!, style: const TextStyle(fontSize: 20)),
                    label: item['label']!,
                    onTap: () {},
                  );
                }),

                const SizedBox(height: 16),

                ...supportOptions.map((option) {
                  return SettingsListItem(
                    leadingIcon: Image.asset(
                      option['iconPath']!,
                      width: 20,
                      height: 20,
                      color: AppColors.neutral60, // 아이콘 색상 적용 (optional)
                    ),
                    label: option['label']!,
                    onTap: () {},
                  );
                }),


                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('고객지원실 운영안내',
                          style: AppTypography.body14SemiBold.copyWith(color: AppColors.neutral60)),
                      const SizedBox(height: 6),
                      Text(
                        '채팅상담 연중무휴 24시간\n유선상담 연중무휴 09:00~18:00\n대표번호 1670-8208',
                        style: AppTypography.caption12Regular.copyWith(color: AppColors.neutral40),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ],
      ),

      // 🔹 하단 내비게이션 바
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
        onTap: (index) => _onNavTap(context, index),
      ),
    );
  }
}
