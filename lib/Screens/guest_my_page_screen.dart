import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/widget/mypage_header.dart';
import 'package:personalized_travel_recommendations/widget/settings_list_item.dart';
import 'package:personalized_travel_recommendations/widget/custom_divider.dart';
import 'package:personalized_travel_recommendations/core/theme/app_solid_png_icons.dart';
import 'package:personalized_travel_recommendations/widget/reusable_prompt_card.dart';

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

            // 로그인 유도 카드
            ReusablePromptCard(
              title: '로그인을 해주세요.',
              subtitle: '계정이 없다면? 가입하기',
              buttonText: '로그인하기',
              onTap: () {
                Navigator.pushNamed(
                    context, '/mypage/loggedin'); //loggen_in_my_page로 이동
              },
            ),

            const SizedBox(height: 24),

            SettingsListItem(
              icon: AppSolidPngIcons.informationCircle(
                  color: AppColors.neutral60),
              label: '공지 사항',
              onTap: () => Navigator.pushNamed(context, '/notice'),
            ),
            const CustomDivider(),
            SettingsListItem(
              icon: AppSolidPngIcons.support(color: AppColors.neutral60),
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
