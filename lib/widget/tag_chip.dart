import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';

class TagChip extends StatelessWidget {
  final String label;

  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.indigo60, //태그 배경색
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.white, //태그 글자색
          fontSize: 12,
        ),
      ),
    );
  }
}
