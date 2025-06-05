import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/core/theme/app_solid_png_icons.dart';
import 'package:personalized_travel_recommendations/core/theme/app_outline_png_icons.dart';

class OrganizeTravelPackagesScreen extends StatefulWidget {
  const OrganizeTravelPackagesScreen({super.key});

  @override
  State<OrganizeTravelPackagesScreen> createState() =>
      _OrganizeTravelPackagesScreenState();
}

class _OrganizeTravelPackagesScreenState
    extends State<OrganizeTravelPackagesScreen> {
  int selectedCategory = 0;
  String searchQuery = '';

  String? selectedTitle;
  String? selectedDescription;

  final List<String> categories = ['항공편', '관광명소', '맛집', '숙소'];

  final List<Map<String, String>> flights = [
    {
      'title': '대한항공 KE123',
      'location': '인천 → 도쿄',
      'description': '출발: 09:00, 도착: 11:30, 직항',
    },
    {
      'title': '아시아나 OZ456',
      'location': '인천 → 도쿄',
      'description': '출발: 13:00, 도착: 15:30, 직항',
    },
  ];

  final List<Map<String, String>> attractions = [
    {
      'title': '디즈니랜드 도쿄',
      'location': '1-1 Maihama, Urayasu, Chiba Prefecture',
      'description': '첫 해외 디즈니랜드, 테마파크의 상징',
      'image': 'assets/images/thumb-1.png',
    },
    {
      'title': '신주쿠 공원',
      'location': '도쿄도 신주쿠구',
      'description': '도심 속 오아시스, 넓은 잔디밭과 조경',
      'image': 'assets/images/thumb-2.png',
    },
    {
      'title': '우에노 공원',
      'location': '도쿄도 타이토구',
      'description': '벚꽃, 단풍 명소, 박물관이 밀집된 공원',
      'image': 'assets/images/thumb-3.png',
    },
    {
      'title': '도쿄 타워',
      'location': '도쿄도 미나토구',
      'description': '도쿄의 상징적인 랜드마크',
      'image': 'assets/images/thumb.png',
    },
  ];

  final List<Map<String, String>> restaurants = [
    {
      'title': '스시 오마카세',
      'location': '도쿄 시부야구',
      'description': '셰프 추천 고급 스시 코스',
      'image': 'assets/images/sushi_omakase.png',
    },
    {
      'title': '라멘 이치란',
      'location': '도쿄 신주쿠구',
      'description': '돈코츠 라멘의 대표 주자',
      'image': 'assets/images/ramen_ichiran.png',
    },
  ];

  final List<Map<String, String>> hotels = [
    {
      'title': '신주쿠 프린스 호텔',
      'location': '도쿄 신주쿠구',
      'description': '교통 편리한 4성급 호텔',
      'image': 'assets/images/shinjuku_prince.png',
    },
    {
      'title': '게이오 플라자 호텔',
      'location': '도쿄 신주쿠구',
      'description': '전망과 객실이 좋은 호텔',
      'image': 'assets/images/keio_plaza.png',
    },
  ];

  List<Map<String, String>> get currentList {
    List<Map<String, String>> baseList;
    switch (selectedCategory) {
      case 0:
        baseList = flights;
        break;
      case 1:
        baseList = attractions;
        break;
      case 2:
        baseList = restaurants;
        break;
      case 3:
        baseList = hotels;
        break;
      default:
        baseList = [];
    }

    if (searchQuery.isEmpty) return baseList;
    return baseList.where((item) {
      final query = searchQuery.toLowerCase();
      return (item['title']?.toLowerCase().contains(query) ?? false) ||
          (item['location']?.toLowerCase().contains(query) ?? false) ||
          (item['description']?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 52,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.neutral10,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppOutlinePngIcons.arrowNarrowLeft(
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: SvgPicture.asset(
          'assets/logos/WordMark.svg',
          width: 108,
          height: 22,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 2,
            color: AppColors.neutral10,
            width: double.infinity,
          ),
        ),
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
        toolbarHeight: 56,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildCategories(),
            // if (selectedTitle != null) _buildSelectedItemDisplay(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  final item = currentList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTitle = item['title'];
                        selectedDescription =
                            selectedCategory == 0 ? item['description'] : null;
                      });
                    },
                    child: _buildTravelCard(
                      item['title'] ?? '',
                      item['location'] ?? '',
                      item['description'] ?? '',
                      item['image'] ?? 'assets/images/thumb-1.png',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildSelectedItemDisplay() {
  //   return Container(
  //     margin: const EdgeInsets.fromLTRB(20, 16, 20, 8),
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: AppColors.indigo10,
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           selectedTitle ?? '',
  //           style: AppTypography.body16Medium,
  //         ),
  //         if (selectedDescription != null) ...[
  //           const SizedBox(height: 8),
  //           Text(
  //             selectedDescription!,
  //             style: AppTypography.body14Regular,
  //           ),
  //         ]
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral10,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: '내용을 검색하세요',
            hintStyle: AppTypography.body14Regular.copyWith(
              color: AppColors.neutral50,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppSolidPngIcons.search(
                color: AppColors.neutral100,
                size: 20,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: AppColors.neutral30,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: AppColors.indigo60,
                width: 1.5,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: List.generate(categories.length, (index) {
            Widget? icon;
            switch (index) {
              case 0:
                icon = AppOutlinePngIcons.flight(
                    size: 20, color: AppColors.neutral100);
                break;
              case 1:
                icon = AppOutlinePngIcons.location(
                    size: 20, color: AppColors.neutral100);
                break;
              case 2:
                icon = AppOutlinePngIcons.tastehouse(
                    size: 20, color: AppColors.neutral100);
                break;
              case 3:
                icon = AppOutlinePngIcons.place(
                    size: 20, color: AppColors.neutral100);
                break;
            }
            return _buildCategoryButtonWithIcon(
              categories[index],
              icon,
              selectedCategory == index,
              onTap: () {
                setState(() {
                  selectedCategory = index;
                });
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCategoryButtonWithIcon(
      String label, Widget? icon, bool isSelected,
      {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.neutral100,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          side: BorderSide(
            color: isSelected ? AppColors.indigo60 : AppColors.neutral30,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: AppTypography.caption12Medium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTravelCard(
    String title,
    String location,
    String description,
    String imagePath,
  ) {
    final bool showImage = selectedCategory != 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showImage)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.neutral20,
                  child: const Icon(Icons.image_not_supported,
                      color: AppColors.neutral100),
                ),
              ),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: showImage ? 12 : 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTypography.subtitle18Bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: AppTypography.body14Regular.copyWith(
                      color: AppColors.neutral60,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: AppTypography.body14Regular,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
