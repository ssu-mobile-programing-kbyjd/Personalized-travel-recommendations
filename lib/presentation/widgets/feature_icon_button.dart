import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';

class FeatureIconButton extends StatelessWidget {
  final Widget icon; // IconData → Widget 변경
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
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 28,
              width: 28,
              child: icon,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              count.toString(),
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
