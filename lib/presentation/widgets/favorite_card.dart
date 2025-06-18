import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/tag_chip.dart';

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
    this.isContent = false,
  });

  @override
  Widget build(BuildContext context) {
    // 🔹 패키지 카드
    if (isPackage) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.neutral10,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral40.withAlpha((0.4*255).toInt()),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 썸네일
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: isAssetImage
                          ? Image.asset(imageUrl, width: 80, height: 80, fit: BoxFit.cover)
                          : Image.network(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),

                    // 텍스트 정보 및 하트
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            subtitle.split('\n')[0],
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.neutral60,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  subtitle.split('\n')[1],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.indigo60,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 15), // ← 왼쪽으로 이동
                                child: Image.asset(
                                  'assets/icons/Solid/png/heart.png',
                                  width: 26,
                                  height: 26,
                                  fit: BoxFit.cover,
                                  color: AppColors.error60,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Center(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: tags.map((tag) => TagChip(label: tag)).toList(),
                  ),
                ),
              ],
            ),

            // 🔼 chevron-right를 카드 우측 상단에 고정
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/icons/Outline/png/cheveron-right.png',
                width: 20,
                height: 20,
                color: AppColors.neutral60,
              ),
            ),
          ],
        ),
      );
    }



    // 🔹 컨텐츠 카드
    if (isContent) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral100.withAlpha((0.1*255).toInt()),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // ✅ 배경 이미지
              SizedBox(
                width: double.infinity,
                height: 125,
                child: isAssetImage
                    ? Image.asset(imageUrl, fit: BoxFit.cover)
                    : Image.network(imageUrl, fit: BoxFit.cover),
              ),

              // ✅ 상단 하트 아이콘
              Positioned(
                top: 8,
                right: 12,
                child: Image.asset(
                  'assets/icons/Solid/png/heart.png',
                  width: 26,
                  height: 26,
                  fit: BoxFit.cover,
                  color: AppColors.error60,
                ),
              ),

              // ✅ 텍스트 및 > 아이콘
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 31, 28, 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '여행 정보',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              '도시 및 국가별 여행 가이드',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4,
                                    color: Colors.black54,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            'assets/icons/Outline/png/cheveron-right.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }



    // 🔹 여행지 카드
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral40.withAlpha((0.4*255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: isAssetImage
                    ? Image.asset(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover)
                    : Image.network(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Image.asset(
                  'assets/icons/Solid/png/heart.png',
                  width: 26,
                  height: 26,
                  fit: BoxFit.cover,
                  color: AppColors.error60,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
                    ],
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/Solid/png/star.png',
                      width: 26,
                      height: 26,
                      fit: BoxFit.cover,
                      color: AppColors.warning40,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.neutral90,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
