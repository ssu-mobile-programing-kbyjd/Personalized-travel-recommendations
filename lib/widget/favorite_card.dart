import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';
import 'tag_chip.dart';

class FavoriteCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double rating;
  final bool isFavorite;
  final List<String> tags;
  final bool isAssetImage;
  final bool isPackage;
  final bool isContent;

  const FavoriteCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.rating,
    this.isFavorite = true,
    this.tags = const [],
    this.isAssetImage = true,
    this.isPackage = false,
    this.isContent = false, // 🔹 초기값
  });

  @override
  Widget build(BuildContext context) {
    if (isPackage) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral20.withOpacity(0.4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: isAssetImage
                      ? Image.asset(imageUrl, width: 80, height: 80, fit: BoxFit.cover)
                      : Image.network(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: AppColors.neutral60)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.favorite, color: AppColors.error60),
              ],
            ),
            const SizedBox(height: 8),
            // 이미지 하단 태그 - 가운데 정렬
            Align(
              alignment: Alignment.center,
              child: Wrap(
                spacing: 6,
                runSpacing: 4,
                alignment: WrapAlignment.center,
                children: tags.map((tag) => TagChip(label: tag)).toList(),
              ),
            ),
          ],
        ),
      );
    }


    // 🔹 컨텐츠 카드 (텍스트 먼저)
    if (isContent) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral20.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // 🔹 배경 이미지
              isAssetImage
                  ? Image.asset(
                imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : Image.network(
                imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              // 🔹 왼쪽 정렬 + 수직 가운데 정렬 텍스트 묶음
              const Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '여행 정보',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '도시 및 국가별 여행 가이드',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black54,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 🔹 오른쪽 상단 하트
              Positioned(
                top: 8,
                right: 12,
                child: Icon(Icons.favorite, color: AppColors.error60),
              ),
            ],
          ),
        ),
      );
    }


    // 🔹 기본 카드 (여행지 등)
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral20.withOpacity(0.4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: isAssetImage
                ? Image.asset(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover)
                : Image.network(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: AppColors.warning40),
                Text(rating.toStringAsFixed(1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
