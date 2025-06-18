import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';

class SettingsListItem extends StatelessWidget {
  final Widget leadingIcon;
  final String label;
  final VoidCallback? onTap;

  const SettingsListItem({
    super.key,
    required this.leadingIcon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon,
      title: Text(
        label,
        style: AppTypography.body14SemiBold.copyWith(
          color: AppColors.neutral80,
        ),
      ),
      trailing: Image.asset(
        'assets/icons/Outline/png/cheveron-right.png',
        width: 20,
        height: 20,
        color: AppColors.neutral40,
      ),
      onTap: onTap,
    );
  }
}
