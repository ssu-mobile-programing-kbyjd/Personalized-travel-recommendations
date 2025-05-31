import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/theme/app_icons.dart';

class SettingsListItem extends StatelessWidget {
  final Widget icon; // <- 아이콘을 위젯으로 받도록 수정됨
  final String label;
  final VoidCallback? onTap;

  const SettingsListItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon, // SVG 아이콘 사용
      title: Text(
        label,
        style: AppTypography.body16Regular.copyWith(
          color: AppColors.neutral80,
        ),
      ),
      trailing: AppIcons.chevronRight(size: 20, color: AppColors.neutral40),
      onTap: onTap,
    );
  }
}
