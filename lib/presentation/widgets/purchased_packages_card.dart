import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/tag_chip.dart';

class TripCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String? statusLabel; // e.g., "예약 완료"
  final String? departureDate; // e.g., "6월 20일 출발"
  final List<String> tags;
  final bool isAssetImage;
  final VoidCallback? onTap;

  const TripCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.statusLabel,
    this.departureDate,
    this.tags = const [],
    this.isAssetImage = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.neutral10,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral100.withAlpha((0.1 * 255).toInt()),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: isAssetImage
                      ? Image.asset(imageUrl, width: 80, height: 80, fit: BoxFit.cover)
                      : Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.neutral90,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.neutral60,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (departureDate != null)
                        Text(
                          departureDate!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.indigo60,
                          ),
                        ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/icons/Outline/png/cheveron-right.png',
                  width: 20,
                  height: 20,
                  color: AppColors.neutral60,
                ),
              ],
            ),
            if (statusLabel != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.indigo10,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusLabel!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.indigo60,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            if (tags.isNotEmpty) ...[
              const SizedBox(height: 12),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 6,
                  runSpacing: 6,
                  children: tags.map((tag) => TagChip(label: tag)).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
