import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/theme/app_icons.dart';

// 하단 네비게이션 바 컴포넌트

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 30,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.home_outlined, size: 28, color: AppColors.neutral40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.neutral10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.calendar_month, color: AppColors.indigo60, size: 24),
                SizedBox(width: 4),
                Text(
                  'Schedule',
                  style: TextStyle(
                    color: AppColors.indigo60,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          //const AppIcons(Icons.public, size: 28, color: AppColors.neutral40),
          //const AppIcons(Icons.menu, size: 28, color: AppColors.neutral40),
        ],
      ),
    );
  }
}
