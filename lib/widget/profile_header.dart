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
                Text(
                  nickname,
                  style: AppTypography.subtitle18Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '맛상추와 함께한지 $daysTogether일째\n그동안 총 $travelCount번의 여행을 떠났어요 :)',
                  style: AppTypography.body14Regular.copyWith(
                    color: AppColors.neutral50,
                    height: 1.4,
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
