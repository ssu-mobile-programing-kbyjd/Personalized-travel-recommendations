import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/mypage_header.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/settings_list_item.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_divider.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/reusable_prompt_card.dart';
import 'package:personalized_travel_recommendations/presentation/pages/mypage/logged_in_my_page_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/mypage/my_page_notice_screen.dart';

class GuestMyPageScreen extends StatelessWidget {
  const GuestMyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyPageHeader(),
            const SizedBox(height: 8),

            // 🔹 로그인 유도 카드
            ReusablePromptCard(
              title: '로그인을 해주세요.',
              subtitle: '계정이 없다면? 가입하기',
              buttonText: '로그인하기',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoggedInMyPageScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // 🔹 설정 항목
            SettingsListItem(
              leadingIcon: Image.asset(
                'assets/icons/Solid/png/clipboard-check.png',
                width: 24,
                height: 24,
                color: AppColors.neutral60,
              ),
              label: '공지 사항',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyPageNoticeScreen(),
                  ),
                );
              },
            ),
            const CustomDivider(),


            SettingsListItem(
              leadingIcon: Image.asset(
                'assets/icons/Outline/png/alert-circle.png',
                width: 24,
                height: 24,
                color: AppColors.neutral60,
              ),
              label: '고객센터',
              onTap: () => Navigator.pushNamed(context, '/support'),
            ),
            const CustomDivider(),
          ],
        ),
      ),
    );
  }
}
