import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';

class MyPageHeader extends StatelessWidget {
  final String title;
  final String brandName;

  const MyPageHeader({
    super.key,
    this.title = '마이페이지',
    this.brandName = '트립블록',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 22, 16, 8),
      child: Row(
        children: [
          Text(
            title,
            style: AppTypography.title24Bold.copyWith(
              color: AppColors.neutral90,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '| $brandName',
            style: AppTypography.title24Bold.copyWith(
              color: AppColors.neutral40,
            ),
          ),
        ],
      ),
    );
  }
}
