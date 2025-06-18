import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String nickname;
  final int daysTogether;
  final int travelCount;
  final String profileImage;
  final Color backgroundColor;

  const ProfileHeader({
    super.key,
    required this.nickname,
    required this.daysTogether,
    required this.travelCount,
    required this.profileImage,
    this.backgroundColor = AppColors.indigo100, // 기본 배경색을 indigo100으로 설정
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(profileImage),
            backgroundColor: AppColors.neutral20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    style: AppTypography.caption12Regular.copyWith(
                      color: AppColors.white,
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(text: '맛상추와 함께한지 '),
                      TextSpan(
                        text: '$daysTogether일',
                        style: AppTypography.button14.copyWith(color: AppColors.white),
                      ),
                      const TextSpan(text: ' 째'),
                      const TextSpan(text: '\n그동안 총 '),
                      TextSpan(
                        text: '$travelCount번',
                        style: AppTypography.button14.copyWith(color: AppColors.white),
                      ),
                      const TextSpan(text: '의 여행을 떠났어요 :)'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
