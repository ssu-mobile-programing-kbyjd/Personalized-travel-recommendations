import 'package:flutter/material.dart';

class TrendingDestinationsScreen extends StatefulWidget {
  const TrendingDestinationsScreen({super.key});

  @override
  State<TrendingDestinationsScreen> createState() => _TrendingDestinationsScreenState();
}

class _TrendingDestinationsScreenState extends State<TrendingDestinationsScreen> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            _buildHeader(),
            
            // 검색바
            _buildSearchBar(),
            
            // 카테고리 필터
            _buildCategoryFilter(),
            
            // 여행지 리스트
            Expanded(
              child: _buildDestinationList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0x0D12121D),
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          // 뒤로가기 버튼
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F4F9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Color(0xFF0F1A2A),
              ),
            ),
          ),
          
          const Spacer(),
          
          // 로고 영역 (플레이스홀더)
          Container(
            width: 107,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          
          const Spacer(),
          
          // 여백 (뒤로가기 버튼과 같은 크기)
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x0D202030),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: '검색어를 입력하세요',
          hintStyle: TextStyle(
            color: Color(0x4D12121D),
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 16, right: 8),
            child: Icon(
              Icons.search,
              color: Color(0xFF64748B),
            ),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = [
      {'name': '스페인', 'icon': Icons.house_outlined},
      {'name': '일본', 'icon': Icons.apartment_outlined},
      {'name': '동남아시아', 'icon': Icons.business_outlined},
      {'name': '미국', 'icon': Icons.home_outlined},
      {'name': '유럽', 'icon': Icons.location_city_outlined},
      {'name': '중국', 'icon': Icons.temple_buddhist_outlined},
      {'name': '인도', 'icon': Icons.temple_hindu_outlined},
      {'name': '호주', 'icon': Icons.waves_outlined},
      {'name': '캐나다', 'icon': Icons.forest_outlined},
      {'name': '브라질', 'icon': Icons.sports_soccer_outlined},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 37,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = index == _selectedCategoryIndex;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: index < categories.length - 1 ? 16 : 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4032DC) : const Color(0xFFF1F4F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    size: 20,
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category['name'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDestinationList() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '요즘 뜨는 여행지',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F1A2A),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 4, // 더 많은 아이템 표시
              itemBuilder: (context, index) => _buildDestinationCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(int index) {
    final destinationsByCategory = [
      // 스페인 (index 0)
      [
        {
          'name': '사그라다 파밀리아',
          'location': '바르셀로나, 스페인',
          'rating': '5.0',
          'status': 'N명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '카사 밀라',
          'location': '바르셀로나, 스페인',
          'rating': '5.0',
          'status': '3명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '구엘 공원',
          'location': '바르셀로나, 스페인',
          'rating': '4.8',
          'status': '15명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '라 페드레라',
          'location': '바르셀로나, 스페인',
          'rating': '4.9',
          'status': '8명이 확인 중',
          'hasButton': true,
        },
      ],
      // 일본 (index 1)
      [
        {
          'name': '센소지 절',
          'location': '도쿄, 일본',
          'rating': '4.8',
          'status': '25명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '후시미 이나리 신사',
          'location': '교토, 일본',
          'rating': '4.9',
          'status': '18명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '오사카 성',
          'location': '오사카, 일본',
          'rating': '4.7',
          'status': '12명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '후지산',
          'location': '시즈오카, 일본',
          'rating': '5.0',
          'status': '30명이 확인 중',
          'hasButton': true,
        },
      ],
      // 동남아시아 (index 2)
      [
        {
          'name': '앙코르 와트',
          'location': '씨엠립, 캄보디아',
          'rating': '5.0',
          'status': '22명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '페트로나스 타워',
          'location': '쿠알라룸푸르, 말레이시아',
          'rating': '4.7',
          'status': '15명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '보라카이',
          'location': '필리핀',
          'rating': '4.8',
          'status': '20명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '하롱베이',
          'location': '베트남',
          'rating': '4.9',
          'status': '18명이 확인 중',
          'hasButton': true,
        },
      ],
      // 미국 (index 3)
      [
        {
          'name': '자유의 여신상',
          'location': '뉴욕, 미국',
          'rating': '4.8',
          'status': '35명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '골든 게이트 브릿지',
          'location': '샌프란시스코, 미국',
          'rating': '4.9',
          'status': '28명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '그랜드 캐니언',
          'location': '애리조나, 미국',
          'rating': '5.0',
          'status': '45명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '옐로스톤',
          'location': '와이오밍, 미국',
          'rating': '4.7',
          'status': '12명이 확인 중',
          'hasButton': true,
        },
      ],
      // 유럽 (index 4)
      [
        {
          'name': '에펠탑',
          'location': '파리, 프랑스',
          'rating': '4.9',
          'status': '50명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '콜로세움',
          'location': '로마, 이탈리아',
          'rating': '4.8',
          'status': '42명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '노이슈반슈타인 성',
          'location': '독일',
          'rating': '4.7',
          'status': '25명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '산토리니',
          'location': '그리스',
          'rating': '5.0',
          'status': '38명이 확인 중',
          'hasButton': true,
        },
      ],
      // 중국 (index 5)
      [
        {
          'name': '만리장성',
          'location': '베이징, 중국',
          'rating': '4.8',
          'status': '60명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '자금성',
          'location': '베이징, 중국',
          'rating': '4.7',
          'status': '45명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '천안문 광장',
          'location': '베이징, 중국',
          'rating': '4.6',
          'status': '32명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '상하이 번드',
          'location': '상하이, 중국',
          'rating': '4.9',
          'status': '28명이 확인 중',
          'hasButton': true,
        },
      ],
      // 인도 (index 6)
      [
        {
          'name': '타지마할',
          'location': '아그라, 인도',
          'rating': '5.0',
          'status': '55명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '암베르 궁전',
          'location': '자이푸르, 인도',
          'rating': '4.8',
          'status': '30명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '갠지스 강',
          'location': '바라나시, 인도',
          'rating': '4.6',
          'status': '22명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '골든 템플',
          'location': '암리차르, 인도',
          'rating': '4.9',
          'status': '18명이 확인 중',
          'hasButton': true,
        },
      ],
      // 호주 (index 7)
      [
        {
          'name': '시드니 오페라 하우스',
          'location': '시드니, 호주',
          'rating': '4.9',
          'status': '40명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '울루루',
          'location': '호주',
          'rating': '4.8',
          'status': '15명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '그레이트 배리어 리프',
          'location': '퀸즐랜드, 호주',
          'rating': '5.0',
          'status': '25명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '트웰브 아포슬스',
          'location': '빅토리아, 호주',
          'rating': '4.7',
          'status': '12명이 확인 중',
          'hasButton': true,
        },
      ],
      // 캐나다 (index 8)
      [
        {
          'name': '나이아가라 폭포',
          'location': '온타리오, 캐나다',
          'rating': '4.8',
          'status': '35명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '밴프 국립공원',
          'location': '앨버타, 캐나다',
          'rating': '5.0',
          'status': '28명이 확인 중',
          'hasButton': true,
        },
        {
          'name': 'CN 타워',
          'location': '토론토, 캐나다',
          'rating': '4.6',
          'status': '20명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '재스퍼 국립공원',
          'location': '앨버타, 캐나다',
          'rating': '4.9',
          'status': '16명이 확인 중',
          'hasButton': true,
        },
      ],
      // 브라질 (index 9)
      [
        {
          'name': '그리스도상',
          'location': '리우데자네이루, 브라질',
          'rating': '4.9',
          'status': '48명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '이과수 폭포',
          'location': '브라질/아르헨티나',
          'rating': '5.0',
          'status': '32명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '코파카바나 해변',
          'location': '리우데자네이루, 브라질',
          'rating': '4.7',
          'status': '25명이 확인 중',
          'hasButton': true,
        },
        {
          'name': '아마존 열대우림',
          'location': '아마조나스, 브라질',
          'rating': '4.8',
          'status': '18명이 확인 중',
          'hasButton': true,
        },
      ],
    ];

    final destinations = destinationsByCategory[_selectedCategoryIndex];
    final destination = destinations[index % destinations.length];
    
    return Container(
      width: 342,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 섹션
          Container(
            height: 134,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Stack(
              children: [
                // 이미지 플레이스홀더
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                ),
                // 찜하기 버튼
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 26.6,
                    height: 26.6,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(13.3),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.favorite_border,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 정보 섹션
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      destination['name'] as String,
                      style: const TextStyle(
                        fontSize: 18.6,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0F1A2A),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 26.6,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          destination['rating'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F1A2A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  destination['location'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      destination['status'] as String,
                      style: const TextStyle(
                        fontSize: 18.6,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4032DC),
                      ),
                    ),
                    const Spacer(),
                    if (destination['hasButton'] as bool)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4032DC),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          '확인하기',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.9),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(24),
        height: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8FC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.home_outlined,
                    size: 24,
                    color: Color(0xFF4032DC),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4032DC),
                    ),
                  ),
                ],
              ),
            ),
            // Calendar
            const Icon(
              Icons.calendar_month_outlined,
              size: 24,
              color: Color(0xFF64748B),
            ),
            // Globe
            const Icon(
              Icons.language_outlined,
              size: 24,
              color: Color(0xFF64748B),
            ),
            // Profile
            const Icon(
              Icons.person_outline,
              size: 24,
              color: Color(0xFF64748B),
            ),
          ],
        ),
      ),
    );
  }
} 