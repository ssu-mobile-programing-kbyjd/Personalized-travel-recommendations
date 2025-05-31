import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/widget/mypage_header.dart';
import 'package:personalized_travel_recommendations/widget/profile_header.dart';
import 'package:personalized_travel_recommendations/widget/feature_icon_button.dart';
import 'package:personalized_travel_recommendations/widget/settings_list_item.dart';
import 'package:personalized_travel_recommendations/widget/custom_divider.dart';
import 'package:personalized_travel_recommendations/theme/app_solid_icons.dart';

class LoggedInMyPageScreen extends StatelessWidget {
  const LoggedInMyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            const MyPageHeader(),
            const SizedBox(height: 8),

            // 🔹 사용자 프로필 카드
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ProfileHeader(
                nickname: '재성구리',
                daysTogether: 125,
                travelCount: 5,
                profileImage: 'assets/images/JaeseongGuri.png',
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 기능 아이콘 4개
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeatureIconButton(
                    icon: AppSolidIcons.shoppingBag(color: AppColors.neutral60),
                    label: '구매 상품',
                    count: 4,
                    backgroundColor: AppColors.indigo40,
                  ),
                  FeatureIconButton(
                    icon: AppSolidIcons.heart(color: AppColors.neutral60),
                    label: '찜한 목록',
                    count: 4,
                    onTap: () => Navigator.pushNamed(context, '/wishlist'), // 이동 추가
                    backgroundColor: AppColors.indigo60,
                  ),
                  FeatureIconButton(
                    icon: AppSolidIcons.chatAlt(color: AppColors.neutral60),
                    label: '게시글',
                    count: 2,
                    backgroundColor: AppColors.indigo40,
                  ),
                  FeatureIconButton(
                    icon: AppSolidIcons.map(color: AppColors.neutral60),
                    label: '여행 도시',
                    count: 2,
                    backgroundColor: AppColors.indigo60,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 설정 리스트
            SettingsListItem(
              icon: AppSolidIcons.user(color: AppColors.neutral60),
              label: '내 정보 등록 및 관리',
              onTap: () {},
            ),
            const CustomDivider(),

            SettingsListItem(
              icon: AppSolidIcons.shoppingCart(color: AppColors.neutral60),
              label: '구매 목록',
              onTap: () {},
            ),
            const CustomDivider(),

            SettingsListItem(
              icon: AppSolidIcons.informationCircle(color: AppColors.neutral60),
              label: '공지 사항',
              onTap: () {},
            ),
            const CustomDivider(),

            SettingsListItem(
              icon: AppSolidIcons.informationCircle(color: AppColors.neutral60),
              label: '고객센터',
              onTap: () {},
            ),
            const CustomDivider(),

            const SizedBox(height: 12),

            // 🔹 로그아웃
            SettingsListItem(
              icon: AppSolidIcons.logout(color: AppColors.error60),
              label: '로그아웃',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/guest');
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 72),
              child: Text(
                'Log out the account',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.neutral40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
