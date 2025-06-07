import 'package:flutter/material.dart';

class InfluencersScreen extends StatefulWidget {
  const InfluencersScreen({super.key});

  @override
  State<InfluencersScreen> createState() => _InfluencersScreenState();
}

class _InfluencersScreenState extends State<InfluencersScreen> {
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
            
            // 인플루언서 리스트
            Expanded(
              child: _buildInfluencerList(),
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
                color: isSelected ? const Color(0xFF4032DC) : const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    size: 20,
                    color: isSelected ? Colors.white : const Color(0xFF939393),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category['name'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isSelected ? Colors.white : const Color(0xFF939393),
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

  Widget _buildInfluencerList() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '맞춤 트립인플루언서',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF101010),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 4, // 여러 인플루언서 표시
              itemBuilder: (context, index) => _buildInfluencerCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfluencerCard(int index) {
    // 카테고리별 인플루언서 데이터 - 더 많은 카테고리 추가
    final influencersByCategory = [
      // 스페인 (index 0)
      [
        {
          'name': '여행 작가 김OO',
          'location': '스페인 전문 가이드',
          'rating': '5.0',
          'status': 'N명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '바르셀로나 가이드 박OO',
          'location': '바르셀로나 거주 10년',
          'rating': '4.9',
          'status': '8명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '스페인어 통역사 이OO',
          'location': '마드리드 전문',
          'rating': '4.8',
          'status': '12명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '플라멩코 강사 최OO',
          'location': '세비야 출신',
          'rating': '4.7',
          'status': '5명이 상담 중',
          'hasButton': true,
        },
      ],
      // 일본 (index 1)
      [
        {
          'name': '트래블 유튜버 박OO',
          'location': '일본 현지 거주 5년',
          'rating': '4.9',
          'status': '8명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '도쿄 가이드 김OO',
          'location': '도쿄 전문',
          'rating': '4.8',
          'status': '15명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '일본어 통역사 이OO',
          'location': '오사카 거주 8년',
          'rating': '4.7',
          'status': '12명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '교토 문화 가이드 최OO',
          'location': '교토 전통 전문',
          'rating': '5.0',
          'status': '20명이 상담 중',
          'hasButton': true,
        },
      ],
      // 동남아시아 (index 2)
      [
        {
          'name': '여행 블로거 이OO',
          'location': '동남아 전문',
          'rating': '4.8',
          'status': '12명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '태국 가이드 박OO',
          'location': '방콕 거주 7년',
          'rating': '4.7',
          'status': '18명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '인도네시아 가이드 김OO',
          'location': '발리 전문',
          'rating': '4.9',
          'status': '10명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '베트남 통역사 최OO',
          'location': '호치민 거주 6년',
          'rating': '4.6',
          'status': '8명이 상담 중',
          'hasButton': true,
        },
      ],
      // 미국 (index 3)
      [
        {
          'name': '가이드 최OO',
          'location': '미국 서부 전문',
          'rating': '4.7',
          'status': '3명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '뉴욕 가이드 김OO',
          'location': '뉴욕 거주 12년',
          'rating': '4.8',
          'status': '15명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '로스앤젤레스 가이드 박OO',
          'location': 'LA 할리우드 전문',
          'rating': '4.6',
          'status': '8명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '샌프란시스코 가이드 이OO',
          'location': '실리콘밸리 전문',
          'rating': '4.9',
          'status': '12명이 상담 중',
          'hasButton': true,
        },
      ],
      // 유럽 (index 4)
      [
        {
          'name': '파리 가이드 김OO',
          'location': '프랑스 문화 전문',
          'rating': '4.9',
          'status': '25명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '이탈리아 가이드 박OO',
          'location': '로마 예술사 전공',
          'rating': '4.8',
          'status': '18명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '독일 가이드 이OO',
          'location': '베를린 거주 8년',
          'rating': '4.7',
          'status': '12명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '그리스 가이드 최OO',
          'location': '산토리니 전문',
          'rating': '5.0',
          'status': '20명이 상담 중',
          'hasButton': true,
        },
      ],
      // 중국 (index 5)
      [
        {
          'name': '중국어 통역사 김OO',
          'location': '베이징 거주 10년',
          'rating': '4.6',
          'status': '30명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '상하이 가이드 박OO',
          'location': '상하이 현지인',
          'rating': '4.7',
          'status': '22명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '만리장성 전문가 이OO',
          'location': '중국 역사 전문',
          'rating': '4.8',
          'status': '15명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '시안 가이드 최OO',
          'location': '병마용 전문가',
          'rating': '4.5',
          'status': '10명이 상담 중',
          'hasButton': true,
        },
      ],
      // 인도 (index 6)
      [
        {
          'name': '인도 가이드 김OO',
          'location': '골든 트라이앵글 전문',
          'rating': '4.8',
          'status': '18명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '타지마할 전문가 박OO',
          'location': '아그라 현지 가이드',
          'rating': '5.0',
          'status': '25명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '케랄라 가이드 이OO',
          'location': '백워터 투어 전문',
          'rating': '4.7',
          'status': '12명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '라자스탄 가이드 최OO',
          'location': '궁전 투어 전문',
          'rating': '4.6',
          'status': '8명이 상담 중',
          'hasButton': true,
        },
      ],
      // 호주 (index 7)
      [
        {
          'name': '호주 가이드 김OO',
          'location': '시드니 거주 15년',
          'rating': '4.8',
          'status': '20명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '멜버른 가이드 박OO',
          'location': '빅토리아 전문',
          'rating': '4.9',
          'status': '15명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '골드코스트 가이드 이OO',
          'location': '서핑 전문가',
          'rating': '4.7',
          'status': '18명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '울루루 가이드 최OO',
          'location': '원주민 문화 전문',
          'rating': '5.0',
          'status': '8명이 상담 중',
          'hasButton': true,
        },
      ],
      // 캐나다 (index 8)
      [
        {
          'name': '캐나다 가이드 김OO',
          'location': '토론토 거주 12년',
          'rating': '4.7',
          'status': '16명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '밴쿠버 가이드 박OO',
          'location': 'BC주 전문',
          'rating': '4.8',
          'status': '12명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '나이아가라 가이드 이OO',
          'location': '폭포 투어 전문',
          'rating': '4.6',
          'status': '22명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '로키산맥 가이드 최OO',
          'location': '국립공원 전문',
          'rating': '5.0',
          'status': '10명이 상담 중',
          'hasButton': true,
        },
      ],
      // 브라질 (index 9)
      [
        {
          'name': '브라질 가이드 김OO',
          'location': '리우 거주 8년',
          'rating': '4.8',
          'status': '14명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '이과수 가이드 박OO',
          'location': '폭포 전문가',
          'rating': '5.0',
          'status': '18명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '상파울루 가이드 이OO',
          'location': '도시 투어 전문',
          'rating': '4.6',
          'status': '12명이 상담 중',
          'hasButton': true,
        },
        {
          'name': '아마존 가이드 최OO',
          'location': '정글 투어 전문',
          'rating': '4.9',
          'status': '8명이 상담 중',
          'hasButton': true,
        },
      ],
    ];

    final influencers = influencersByCategory[_selectedCategoryIndex];
    final influencer = influencers[index % influencers.length];
    
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
                      influencer['name'] as String,
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
                          influencer['rating'] as String,
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
                  influencer['location'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      influencer['status'] as String,
                      style: const TextStyle(
                        fontSize: 18.6,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4032DC),
                      ),
                    ),
                    const Spacer(),
                    if (influencer['hasButton'] as bool)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4032DC),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          '상담하기',
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