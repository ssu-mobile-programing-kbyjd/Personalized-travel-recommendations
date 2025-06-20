import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';

class FeatureIconButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final int count;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;

  const FeatureIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
    this.onTap,
    this.backgroundColor = AppColors.purple40,
    this.textColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 88, //height 넣으니까 오류 나서 피그마 디자인과 다르게 진행
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: icon,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.caption12Medium.copyWith(color: textColor),
            ),
            const SizedBox(height: 4),
            Text(
              count.toString(),
              style: AppTypography.subtitle18SemiBold.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
