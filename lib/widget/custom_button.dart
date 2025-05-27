import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.indigo60,
    this.textColor = Colors.white, // Default text color set to white
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: AppTypography.link14.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const CustomNextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.neutral30, // 0xFFCBD4E1
    this.textColor = AppColors.neutral60, // 0xFF64748B
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 358,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.only(bottom: 42),
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: AppTypography.body16Medium.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
