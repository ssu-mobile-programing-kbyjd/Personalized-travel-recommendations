import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/mypage_header.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/profile_header.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/feature_icon_button.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/settings_list_item.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_divider.dart';
//import 'package:personalized_travel_recommendations/presentation/widgets/custom_navbar.dart';
import 'package:personalized_travel_recommendations/presentation/pages/main_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/mypage/my_page_notice_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/mypage/my_page_wishlist_modal_wrapper.dart';
import 'package:personalized_travel_recommendations/presentation/pages/mypage/my_page_support_center_screen.dart';

class LoggedInMyPageScreen extends StatelessWidget {
  const LoggedInMyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.indigo10, // AppColors.indigo 그라데이션 시작
              Colors.white,      // 아래로 갈수록 흰색
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              const MyPageHeader(),
              const SizedBox(height: 8),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ProfileHeader(
                  nickname: '재성구리',
                  daysTogether: 125,
                  travelCount: 5,
                  profileImage: 'assets/images/JaeseongGuri.png',
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FeatureIconButton(
                      icon: Image.asset(
                        'assets/icons/Solid/png/shopping-bag.png',
                        width: 24,
                        height: 24,
                        color: AppColors.white,
                      ),
                      label: '구매 상품',
                      count: 4,
                      backgroundColor: AppColors.indigo40,
                    ),
                    FeatureIconButton(
                      icon: Image.asset(
                        'assets/icons/Solid/png/heart.png',
                        width: 24,
                        height: 24,
                        color: AppColors.white,
                      ),
                      label: '찜한 목록',
                      count: 4,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const WishlistModalWrapper(),
                        );
                      },
                      backgroundColor: AppColors.indigo60,
                    ),
                    FeatureIconButton(
                      icon: Image.asset(
                        'assets/icons/Solid/png/chat-alt.png',
                        width: 24,
                        height: 24,
                        color: AppColors.white,
                      ),
                      label: '게시글',
                      count: 2,
                      backgroundColor: AppColors.indigo40,
                    ),
                    FeatureIconButton(
                      icon: Image.asset(
                        'assets/icons/Solid/png/map.png',
                        width: 24,
                        height: 24,
                        color: AppColors.white,
                      ),
                      label: '여행 도시',
                      count: 2,
                      backgroundColor: AppColors.indigo60,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SettingsListItem(
                leadingIcon: Image.asset(
                  'assets/icons/Solid/png/account_circle.png',
                  width: 24,
                  height: 24,
                  color: AppColors.neutral60,
                ),
                label: '내 정보 등록 및 관리',
                onTap: () {},
              ),
              const CustomDivider(),

              SettingsListItem(
                leadingIcon: Image.asset(
                  'assets/icons/Outline/png/shopping-bag.png',
                  width: 24,
                  height: 24,
                  color: AppColors.neutral60,
                ),
                label: '구매 목록',
                onTap: () {},
              ),
              const CustomDivider(),

              SettingsListItem(
                leadingIcon: Image.asset(
                  'assets/icons/Outline/png/clipboard-check.png',
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SupportCenterScreen(),
                    ),
                  );
                },
              ),
              const CustomDivider(),

              const SizedBox(height: 12),

              SettingsListItem(
                leadingIcon: Image.asset(
                  'assets/icons/Outline/png/logout2.png',
                  width: 24,
                  height: 24,
                  color: AppColors.error60,
                ),
                label: '로그아웃',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MainScreen(initialIndex: 2, isLoggedIn: false),
                    ),
                  );
                },
              ),
              Transform.translate(
                offset: const Offset(0, -10),
                child: const Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Text(
                    'Log out the account',
                    style: TextStyle(fontSize: 12, color: AppColors.neutral40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}