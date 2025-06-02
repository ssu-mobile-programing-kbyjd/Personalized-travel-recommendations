import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/theme/app_outline_png_icons.dart';
import 'package:personalized_travel_recommendations/theme/app_solid_png_icons.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    this.selectedIndex = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, // 배경색 추가
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral10, // 더 연한 그림자
            offset: Offset(0, -4), // 위쪽으로 그림자
            blurRadius: 16, // 더 부드러운 블러 효과
            spreadRadius: 0, // 그림자 확산 정도
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 34),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavItem(
              icon: selectedIndex == 0
                  ? AppSolidPngIcons.home()
                  : AppOutlinePngIcons.navhome(),
              label: 'Home',
              selected: selectedIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: selectedIndex == 1
                  ? AppSolidPngIcons.calendar()
                  : AppOutlinePngIcons.navcalendar(),
              label: 'Calendar',
              selected: selectedIndex == 1,
              onTap: () => onTap(1),
            ),
            _NavItem(
              icon: selectedIndex == 2
                  ? AppSolidPngIcons.profile()
                  : AppOutlinePngIcons.profile(),
              label: 'My Page',
              selected: selectedIndex == 2,
              onTap: () => onTap(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: selected
            ? BoxDecoration(
                color: AppColors.neutral10,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            if (selected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTypography.caption12Medium.copyWith(
                  color: AppColors.indigo60,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
