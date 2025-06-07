import 'package:flutter/material.dart';

class TravelPackagesScreen extends StatefulWidget {
  const TravelPackagesScreen({super.key});

  @override
  State<TravelPackagesScreen> createState() => _TravelPackagesScreenState();
}

class _TravelPackagesScreenState extends State<TravelPackagesScreen> {
  int _selectedCategoryIndex = 0; // 선택된 카테고리 인덱스 추가

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
            
            // 패키지 리스트
            Expanded(
              child: _buildPackageList(),
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

  Widget _buildPackageList() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '최근 업데이트 된 여행 패키지',
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
              itemBuilder: (context, index) => _buildPackageCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(int index) {
    // 카테고리별 패키지 데이터 - 더 많은 카테고리 추가
    final packagesByCategory = [
      // 스페인 (index 0)
      [
        {
          'name': '스페인 완전정복',
          'location': '바르셀로나, 마드리드',
          'rating': '5.0',
          'status': 'N명이 예약 중',
          'hasButton': true,
          'duration': '2박 3일',
          'originalPrice': '₩1,200,000',
          'price': '₩899,000',
        },
        {
          'name': '바르셀로나 가우디 투어',
          'location': '바르셀로나',
          'rating': '4.9',
          'status': '8명이 예약 중',
          'hasButton': true,
          'duration': '3박 4일',
          'originalPrice': '₩1,500,000',
          'price': '₩1,199,000',
        },
        {
          'name': '마드리드 & 톨레도',
          'location': '마드리드, 톨레도',
          'rating': '4.8',
          'status': '12명이 예약 중',
          'hasButton': true,
          'duration': '2박 3일',
          'originalPrice': '₩900,000',
          'price': '₩699,000',
        },
        {
          'name': '스페인 남부 투어',
          'location': '세비야, 그라나다',
          'rating': '4.7',
          'status': '5명이 예약 중',
          'hasButton': true,
          'duration': '3박 4일',
          'originalPrice': '₩1,300,000',
          'price': '₩999,000',
        },
      ],
      // 일본 (index 1)
      [
        {
          'name': '일본 벚꽃 투어',
          'location': '도쿄, 오사카, 교토',
          'rating': '4.9',
          'status': '12명이 예약 중',
          'hasButton': true,
          'duration': '4박 5일',
          'originalPrice': '₩1,200,000',
          'price': '₩899,000',
        },
        {
          'name': '도쿄 디즈니랜드',
          'location': '도쿄',
          'rating': '4.8',
          'status': '25명이 예약 중',
          'hasButton': true,
          'duration': '3박 4일',
          'originalPrice': '₩900,000',
          'price': '₩699,000',
        },
        {
          'name': '교토 전통 체험',
          'location': '교토',
          'rating': '4.7',
          'status': '8명이 예약 중',
          'hasButton': true,
          'duration': '3박 4일',
          'originalPrice': '₩1,000,000',
          'price': '₩799,000',
        },
        {
          'name': '오사카 먹거리 투어',
          'location': '오사카',
          'rating': '4.9',
          'status': '18명이 예약 중',
          'hasButton': true,
          'duration': '2박 3일',
          'originalPrice': '₩800,000',
          'price': '₩599,000',
        },
      ],
      // 동남아시아 (index 2)
      [
        {
          'name': '동남아 힐링',
          'location': '발리, 푸켓',
          'rating': '4.8',
          'status': '8명이 예약 중',
          'hasButton': true,
          'duration': '5박 6일',
          'originalPrice': '₩800,000',
          'price': '₩599,000',
        },
        {
          'name': '앙코르 와트 탐험',
          'location': '씨엠립',
          'rating': '5.0',
          'status': '12명이 예약 중',
          'hasButton': true,
          'duration': '3박 4일',
          'originalPrice': '₩1,000,000',
          'price': '₩799,000',
        },
        {
          'name': '말레이시아 쿠알라룸푸르',
          'location': '쿠알라룸푸르',
          'rating': '4.7',
          'status': '5명이 예약 중',
          'hasButton': true,
          'duration': '3박 4일',
          'originalPrice': '₩700,000',
          'price': '₩499,000',
        },
        {
          'name': '태국 방콕 & 파타야',
          'location': '방콕, 파타야',
          'rating': '4.6',
          'status': '20명이 예약 중',
          'hasButton': true,
          'duration': '4박 5일',
          'originalPrice': '₩900,000',
          'price': '₩699,000',
        },
      ],
      // 미국 (index 3)
      [
        {
          'name': '미국 서부 투어',
          'location': 'LA, 샌프란시스코',
          'rating': '4.7',
          'status': '5명이 예약 중',
          'hasButton': true,
          'duration': '7박 8일',
          'originalPrice': '₩2,600,000',
          'price': '₩2,199,000',
        },
        {
          'name': '뉴욕 시티 투어',
          'location': '뉴욕',
          'rating': '4.8',
          'status': '15명이 예약 중',
          'hasButton': true,
          'duration': '5박 6일',
          'originalPrice': '₩2,300,000',
          'price': '₩1,899,000',
        },
        {
          'name': '그랜드 캐니언',
          'location': '애리조나',
          'rating': '5.0',
          'status': '8명이 예약 중',
          'hasButton': true,
          'duration': '4박 5일',
          'originalPrice': '₩2,000,000',
          'price': '₩1,599,000',
        },
        {
          'name': '플로리다 올랜도',
          'location': '올랜도',
          'rating': '4.6',
          'status': '12명이 예약 중',
          'hasButton': true,
          'duration': '6박 7일',
          'originalPrice': '₩2,200,000',
          'price': '₩1,799,000',
        },
      ],
      // 유럽 (index 4)
      [
        {
          'name': '프랑스 파리 투어',
          'location': '파리',
          'rating': '4.9',
          'status': '25명이 예약 중',
          'hasButton': true,
          'duration': '5박 6일',
          'originalPrice': '₩1,800,000',
          'price': '₩1,399,000',
        },
        {
          'name': '이탈리아 로마 투어',
          'location': '로마, 플로렌스',
          'rating': '4.8',
          'status': '18명이 예약 중',
          'hasButton': true,
          'duration': '6박 7일',
          'originalPrice': '₩2,000,000',
          'price': '₩1,599,000',
        },
        {
          'name': '독일 로맨틱 가도',
          'location': '뮌헨, 노이슈반슈타인',
          'rating': '4.7',
          'status': '12명이 예약 중',
          'hasButton': true,
          'duration': '5박 6일',
          'originalPrice': '₩1,700,000',
          'price': '₩1,299,000',
        },
        {
          'name': '그리스 산토리니',
          'location': '산토리니, 아테네',
          'rating': '5.0',
          'status': '20명이 예약 중',
          'hasButton': true,
          'duration': '6박 7일',
          'originalPrice': '₩2,200,000',
          'price': '₩1,799,000',
        },
      ],
      // 중국 (index 5)
      [
        {
          'name': '중국 베이징 투어',
          'location': '베이징',
          'rating': '4.6',
          'status': '30명이 예약 중',
          'hasButton': true,
          'duration': '4박 5일',
          'originalPrice': '₩1,000,000',
          'price': '₩799,000',
        },
        {
          'name': '상하이 모던 투어',
          'location': '상하이',
          'rating': '4.7',
          'status': '22명이 예약 중',
          'hasButton': true,
          'duration': '3박 4일',
          'originalPrice': '₩900,000',
          'price': '₩699,000',
        },
        {
          'name': '만리장성 투어',
          'location': '베이징',
          'rating': '4.8',
          'status': '15명이 예약 중',
          'hasButton': true,
          'duration': '3박 4일',
          'originalPrice': '₩1,100,000',
          'price': '₩899,000',
        },
        {
          'name': '시안 병마용 투어',
          'location': '시안',
          'rating': '4.5',
          'status': '10명이 예약 중',
          'hasButton': true,
          'duration': '3박 4일',
          'originalPrice': '₩1,000,000',
          'price': '₩799,000',
        },
      ],
      // 인도 (index 6)
      [
        {
          'name': '인도 골든 트라이앵글',
          'location': '델리, 아그라, 자이푸르',
          'rating': '4.8',
          'status': '18명이 예약 중',
          'hasButton': true,
          'duration': '6박 7일',
          'originalPrice': '₩1,400,000',
          'price': '₩1,099,000',
        },
        {
          'name': '타지마할 투어',
          'location': '아그라',
          'rating': '5.0',
          'status': '25명이 예약 중',
          'hasButton': true,
          'duration': '4박 5일',
          'originalPrice': '₩1,200,000',
          'price': '₩899,000',
        },
        {
          'name': '케랄라 백워터',
          'location': '코치, 알레피',
          'rating': '4.7',
          'status': '12명이 예약 중',
          'hasButton': true,
          'duration': '5박 6일',
          'originalPrice': '₩1,300,000',
          'price': '₩999,000',
        },
        {
          'name': '라자스탄 궁전 투어',
          'location': '자이푸르, 우다이푸르',
          'rating': '4.6',
          'status': '8명이 예약 중',
          'hasButton': true,
          'duration': '5박 6일',
          'originalPrice': '₩1,500,000',
          'price': '₩1,199,000',
        },
      ],
      // 호주 (index 7)
      [
        {
          'name': '호주 시드니 투어',
          'location': '시드니',
          'rating': '4.8',
          'status': '20명이 예약 중',
          'hasButton': true,
          'duration': '5박 6일',
          'originalPrice': '₩2,000,000',
          'price': '₩1,599,000',
        },
        {
          'name': '멜버른 그레이트 오션 로드',
          'location': '멜버른',
          'rating': '4.9',
          'status': '15명이 예약 중',
          'hasButton': true,
          'duration': '6박 7일',
          'originalPrice': '₩2,200,000',
          'price': '₩1,799,000',
        },
        {
          'name': '골드코스트 투어',
          'location': '골드코스트',
          'rating': '4.7',
          'status': '18명이 예약 중',
          'hasButton': true,
          'duration': '4박 5일',
          'originalPrice': '₩1,800,000',
          'price': '₩1,399,000',
        },
        {
          'name': '울루루 에어즈록',
          'location': '앨리스 스프링스',
          'rating': '5.0',
          'status': '8명이 예약 중',
          'hasButton': true,
          'duration': '4박 5일',
          'originalPrice': '₩2,500,000',
          'price': '₩1,999,000',
        },
      ],
      // 캐나다 (index 8)
      [
        {
          'name': '캐나다 동부 투어',
          'location': '토론토, 오타와',
          'rating': '4.7',
          'status': '16명이 예약 중',
          'hasButton': true,
          'duration': '6박 7일',
          'originalPrice': '₩2,000,000',
          'price': '₩1,599,000',
        },
        {
          'name': '밴쿠버 & 빅토리아',
          'location': '밴쿠버',
          'rating': '4.8',
          'status': '12명이 예약 중',
          'hasButton': true,
          'duration': '5박 6일',
          'originalPrice': '₩1,900,000',
          'price': '₩1,499,000',
        },
        {
          'name': '나이아가라 폭포 투어',
          'location': '토론토',
          'rating': '4.6',
          'status': '22명이 예약 중',
          'hasButton': true,
          'duration': '4박 5일',
          'originalPrice': '₩1,600,000',
          'price': '₩1,299,000',
        },
        {
          'name': '로키산맥 국립공원',
          'location': '밴프, 재스퍼',
          'rating': '5.0',
          'status': '10명이 예약 중',
          'hasButton': true,
          'duration': '7박 8일',
          'originalPrice': '₩2,500,000',
          'price': '₩1,999,000',
        },
      ],
      // 브라질 (index 9)
      [
        {
          'name': '브라질 리우데자네이루',
          'location': '리우데자네이루',
          'rating': '4.8',
          'status': '14명이 예약 중',
          'hasButton': true,
          'duration': '5박 6일',
          'originalPrice': '₩1,800,000',
          'price': '₩1,399,000',
        },
        {
          'name': '이과수 폭포 투어',
          'location': '이과수',
          'rating': '5.0',
          'status': '18명이 예약 중',
          'hasButton': true,
          'duration': '4박 5일',
          'originalPrice': '₩1,600,000',
          'price': '₩1,299,000',
        },
        {
          'name': '상파울루 투어',
          'location': '상파울루',
          'rating': '4.6',
          'status': '12명이 예약 중',
          'hasButton': true,
          'duration': '4박 5일',
          'originalPrice': '₩1,500,000',
          'price': '₩1,199,000',
        },
        {
          'name': '아마존 정글 투어',
          'location': '마나우스',
          'rating': '4.9',
          'status': '8명이 예약 중',
          'hasButton': true,
          'duration': '6박 7일',
          'originalPrice': '₩2,200,000',
          'price': '₩1,799,000',
        },
      ],
    ];

    final packages = packagesByCategory[_selectedCategoryIndex];
    final package = packages[index % packages.length];
    
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
                // 기간 배지
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      package['duration'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                      package['name'] as String,
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
                          package['rating'] as String,
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
                  package['location'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 20),
                // 가격 정보
                Row(
                  children: [
                    Text(
                      package['originalPrice'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF94A3B8),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      package['price'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4032DC),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      package['status'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4032DC),
                      ),
                    ),
                    const Spacer(),
                    if (package['hasButton'] as bool)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4032DC),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          '예약하기',
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