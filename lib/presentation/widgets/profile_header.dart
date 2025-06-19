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
    this.backgroundColor = AppColors.indigo100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              profileImage,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, size: 75, color: Colors.white);
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nickname,
                  style: AppTypography.subtitle18SemiBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    style: AppTypography.body14Regular.copyWith(
                      color: AppColors.white,
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(text: '트립블록과 함께한지 '),
                      TextSpan(
                        text: '$daysTogether일',
                        style: AppTypography.subtitle16SemiBold.copyWith(color: AppColors.white),
                      ),
                      const TextSpan(text: ' 째\n그동안 총 '),
                      TextSpan(
                        text: '$travelCount번',
                        style: AppTypography.subtitle16SemiBold.copyWith(color: AppColors.white),
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
