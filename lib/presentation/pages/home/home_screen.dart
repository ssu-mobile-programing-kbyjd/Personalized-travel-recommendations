import 'package:flutter/material.dart';
import 'trending_destinations_screen.dart';
import 'travel_packages_screen.dart';
import '/presentation/pages/home/influencers_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final PageController _bannerPageController = PageController();
  int _currentBannerPage = 0;
  int _selectedCategoryIndex = 0; // 선택된 카테고리 인덱스

  // 위치 선택 단계 관련 변수들
  String? _selectedContinent;
  String? _selectedCountry;
  String? _selectedCity;
  int _locationStep = 0; // 0: 초기상태, 1: 대륙선택, 2: 국가선택, 3: 도시선택, 4: 완료

  // 위치 데이터
  final Map<String, Map<String, List<String>>> _locationData = {
    '아시아': {
      '대한민국': ['서울', '부산', '대구', '인천', '광주', '대전', '울산'],
      '일본': ['도쿄', '오사카', '교토', '요코하마', '나고야', '삿포로', '후쿠오카'],
      '중국': ['베이징', '상하이', '광저우', '선전', '청두', '시안', '항저우'],
      '태국': ['방콕', '치앙마이', '푸켓', '파타야', '후아힌', '크라비'],
      '싱가포르': ['싱가포르'],
      '말레이시아': ['쿠알라룸푸르', '페낭', '조호르바루', '코타키나발루'],
      '인도네시아': ['자카르타', '발리', '족자카르타', '수라바야'],
      '베트남': ['하노이', '호치민', '다낭', '하롱베이', '나트랑'],
      '필리핀': ['마닐라', '세부', '보라카이', '팔라완'],
      '인도': ['뉴델리', '뭄바이', '콜카타', '첸나이', '방갈로르', '자이푸르'],
    },
    '유럽': {
      '프랑스': ['파리', '마르세유', '리옹', '니스', '스트라스부르', '보르도'],
      '이탈리아': ['로마', '밀라노', '베네치아', '피렌체', '나폴리', '토리노'],
      '스페인': ['마드리드', '바르셀로나', '세비야', '발렌시아', '빌바오', '그라나다'],
      '독일': ['베를린', '뮌헨', '프랑크푸르트', '함부르크', '쾰른', '드레스덴'],
      '영국': ['런던', '맨체스터', '버밍엄', '에든버러', '글래스고', '리버풀'],
      '네덜란드': ['암스테르담', '로테르담', '헤이그', '위트레흐트'],
      '스위스': ['취리히', '제네바', '바젤', '베른', '루체른'],
      '오스트리아': ['비엔나', '잘츠부르크', '인스브루크', '그라츠'],
      '그리스': ['아테네', '테살로니키', '산토리니', '미코노스', '로도스'],
    },
    '북미': {
      '미국': ['뉴욕', '로스앤젤레스', '시카고', '휴스턴', '피닉스', '필라델피아', '샌안토니오', '샌디에이고', '댈러스', '산호세', '오스틴', '샌프란시스코'],
      '캐나다': ['토론토', '몬트리올', '밴쿠버', '캘거리', '에드먼턴', '오타와', '위니펙'],
      '멕시코': ['멕시코시티', '과달라하라', '몬테레이', '푸에블라', '티후아나', '칸쿤'],
    },
    '남미': {
      '브라질': ['상파울루', '리우데자네이루', '브라질리아', '살바도르', '포르탈레자', '벨루오리존치'],
      '아르헨티나': ['부에노스아이레스', '코르도바', '로사리오', '멘도사', '라플라타'],
      '페루': ['리마', '쿠스코', '아레키파', '트루히요'],
      '칠레': ['산티아고', '발파라이소', '콘셉시온', '안토파가스타'],
      '콜롬비아': ['보고타', '메데인', '칼리', '바랑키야'],
    },
    '아프리카': {
      '남아프리카공화국': ['케이프타운', '요하네스버그', '더반', '프리토리아'],
      '이집트': ['카이로', '알렉산드리아', '기자', '룩소르'],
      '모로코': ['카사블랑카', '라바트', '마라케시', '페스'],
      '케냐': ['나이로비', '몸바사', '키수무'],
      '탄자니아': ['다르에스살람', '아루샤', '음완자'],
    },
    '오세아니아': {
      '호주': ['시드니', '멜버른', '브리즈번', '퍼스', '애들레이드', '골드코스트', '캔버라'],
      '뉴질랜드': ['오클랜드', '웰링턴', '크라이스트처치', '해밀턴', '타우랑가'],
      '피지': ['수바', '나디', '라우토카'],
    },
  };

  @override
  void initState() {
    super.initState();
    // 기본값 설정
    _selectedContinent = '아시아';
    _selectedCountry = '대한민국';
    _selectedCity = '서울';
    _locationStep = 4; // 초기에는 완료 상태로 설정
  }

  @override
  void dispose() {
    _bannerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 상단 헤더
              _buildHeader(),

              // 카테고리 선택
              _buildCategorySection(),

              // 메인 콘텐츠 배너 (슬라이드 가능)
              _buildMainContentBanner(),

              // 요즘 뜨는 여행지 섹션
              _buildTrendingDestinations(),

              // 최근 업데이트 된 여행 패키지 섹션
              _buildRecentPackages(),

              // 맞춤 트립인플루언서 섹션
              _buildCustomInfluencers(),

              const SizedBox(height: 100), // 하단 네비게이션을 위한 여백
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // 위치 아이콘 (플레이스홀더)
          Container(
            width: 33,
            height: 49,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 8),
          // 현재 위치 정보 (인라인 위치 선택)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '당신은 지금,',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 4),
                _buildInlineLocationSelector(),
              ],
            ),
          ),
          // 알림 버튼
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE2E8F0)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.notifications_outlined,
                    size: 24,
                    color: Color(0xFF0F1A2A),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFCF4920),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineLocationSelector() {
    switch (_locationStep) {
      case 0: // 초기 상태 - 클릭 가능한 위치 버튼
        return _buildInlineLocationButton();
      case 1: // 대륙 선택
        return _buildInlineContinentDropdown();
      case 2: // 국가 선택
        return _buildInlineCountryDropdown();
      case 3: // 도시 선택
        return _buildInlineCityDropdown();
      case 4: // 완료 상태 - 최종 위치 표시
        return _buildInlineFinalLocation();
      default:
        return _buildInlineLocationButton();
    }
  }

  Widget _buildInlineLocationButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _locationStep = 1;
          _selectedContinent = null;
          _selectedCountry = null;
          _selectedCity = null;
        });
      },
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            size: 20,
            color: Color(0xFF0F1A2A),
          ),
          const SizedBox(width: 4),
          const Text(
            '위치를 선택해주세요',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: Color(0xFF64748B),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineContinentDropdown() {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          size: 20,
          color: Color(0xFF4C4DDC),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedContinent,
              hint: const Text(
                '대륙 선택',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4C4DDC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: Color(0xFF4C4DDC),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF0F1A2A),
                fontWeight: FontWeight.w600,
              ),
              items: _locationData.keys.map<DropdownMenuItem<String>>((String continent) {
                return DropdownMenuItem<String>(
                  value: continent,
                  child: Text(continent),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedContinent = newValue;
                  _selectedCountry = null;
                  _selectedCity = null;
                  _locationStep = 2;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInlineCountryDropdown() {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          size: 20,
          color: Color(0xFF4C4DDC),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCountry,
              hint: Text(
                '$_selectedContinent > 국가 선택',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4C4DDC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: Color(0xFF4C4DDC),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF0F1A2A),
                fontWeight: FontWeight.w600,
              ),
              items: _locationData[_selectedContinent!]?.keys.map<DropdownMenuItem<String>>((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCountry = newValue;
                  _selectedCity = null;
                  _locationStep = 3;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInlineCityDropdown() {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          size: 20,
          color: Color(0xFF4C4DDC),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCity,
              hint: Text(
                '$_selectedCountry > 도시 선택',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4C4DDC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: Color(0xFF4C4DDC),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF0F1A2A),
                fontWeight: FontWeight.w600,
              ),
              items: _locationData[_selectedContinent!]?[_selectedCountry!]?.map<DropdownMenuItem<String>>((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue;
                  _locationStep = 4;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInlineFinalLocation() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _locationStep = 0;
        });
      },
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            size: 20,
            color: Color(0xFF10B981),
          ),
          const SizedBox(width: 4),
          Text(
            '$_selectedCity, $_selectedCountry',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F1A2A),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.check_circle,
            size: 16,
            color: Color(0xFF10B981),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
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
      margin: const EdgeInsets.all(16),
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
                color: isSelected ? const Color(0xFF4032DC) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? const Color(0xFF4032DC) : const Color(0xFFE2E8F0),
                ),
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

  Widget _buildMainContentBanner() {
    final banners = [
      {
        'title': '여행 정보',
        'subtitle': '도시 및 국가별 여행 가이드',
        'description': '날씨, 교통, 문화 정보 등에 대해 알아볼까요?',
        'buttonText': '자세히 보러가기 >>',
        'gradient': [Colors.blue.shade400, Colors.blue.shade600],
      },
      {
        'title': '인기 여행지',
        'subtitle': '2024년 가장 핫한 여행지',
        'description': '트렌디한 여행지와 숨겨진 명소를 발견하세요',
        'buttonText': '인기 여행지 보기 >>',
        'gradient': [Colors.purple.shade400, Colors.purple.shade600],
      },
      {
        'title': '특가 패키지',
        'subtitle': '지금만 누릴 수 있는 할인 혜택',
        'description': '최대 50% 할인된 패키지를 만나보세요',
        'buttonText': '특가 패키지 보기 >>',
        'gradient': [Colors.orange.shade400, Colors.orange.shade600],
      },
      {
        'title': '여행 가이드',
        'subtitle': '현지인과 함께하는 프리미엄 여행',
        'description': '전문 가이드와 함께하는 특별한 경험',
        'buttonText': '가이드 만나보기 >>',
        'gradient': [Colors.green.shade400, Colors.green.shade600],
      },
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      height: 345,
      child: PageView.builder(
        controller: _bannerPageController,
        onPageChanged: (int page) {
          setState(() {
            _currentBannerPage = page;
          });
        },
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return GestureDetector(
            onTap: () async {
              // 홀수 배너(index 0, 2, ...)는 mediamba.ssu.ac.kr로, 짝수 배너(index 1, 3, ...)는 naver.com으로
              String url;
              if (index % 2 == 0) {
                // 홀수 배너 (0, 2, 4...)
                url = 'https://mediamba.ssu.ac.kr/';
              } else {
                // 짝수 배너 (1, 3, 5...)
                url = 'https://naver.com';
              }

              try {
                final Uri uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              } catch (e) {
                print('URL 열기 실패: $e');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: banner['gradient'] as List<Color>,
                ),
              ),
              child: Stack(
                children: [
                  // 배경 이미지 플레이스홀더
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  // 콘텐츠
                  Positioned(
                    bottom: 24,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banner['title'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          banner['subtitle'] as String,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          banner['description'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          banner['buttonText'] as String,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 페이지 인디케이터
                        Row(
                          children: List.generate(
                            banners.length,
                                (pageIndex) => Container(
                              margin: const EdgeInsets.only(right: 4),
                              width: pageIndex == _currentBannerPage ? 40 : 6,
                              height: 2,
                              decoration: BoxDecoration(
                                color: pageIndex == _currentBannerPage
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 찜하기 버튼
                  Positioned(
                    top: 24,
                    right: 24,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                        size: 20,
                      ),
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

  Widget _buildTrendingDestinations() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '요즘 뜨는 여행지',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F1A2A),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrendingDestinationsScreen(),
                    ),
                  );
                },
                child: const Text(
                  '전체 보기',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4C4DDC),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => _buildDestinationCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(int index) {
    // 카테고리별 여행지 데이터
    final destinationsByCategory = [
      // 스페인 (index 0)
      [
        {
          'name': '사그라다 파밀리아',
          'location': '바르셀로나, 스페인',
          'rating': '5.0',
          'status': 'N명이 확인 중',
        },
        {
          'name': '카사 밀라',
          'location': '바르셀로나, 스페인',
          'rating': '5.0',
          'status': '3명이 확인 중',
        },
        {
          'name': '구엘 공원',
          'location': '바르셀로나, 스페인',
          'rating': '4.8',
          'status': '15명이 확인 중',
        },
        {
          'name': '라 페드레라',
          'location': '바르셀로나, 스페인',
          'rating': '4.9',
          'status': '8명이 확인 중',
        },
        {
          'name': '알함브라 궁전',
          'location': '그라나다, 스페인',
          'rating': '4.7',
          'status': '12명이 확인 중',
        },
      ],
      // 일본 (index 1)
      [
        {
          'name': '센소지 절',
          'location': '도쿄, 일본',
          'rating': '4.8',
          'status': '25명이 확인 중',
        },
        {
          'name': '후시미 이나리 신사',
          'location': '교토, 일본',
          'rating': '4.9',
          'status': '18명이 확인 중',
        },
        {
          'name': '오사카 성',
          'location': '오사카, 일본',
          'rating': '4.7',
          'status': '12명이 확인 중',
        },
        {
          'name': '도도지 절',
          'location': '나라, 일본',
          'rating': '4.6',
          'status': '8명이 확인 중',
        },
        {
          'name': '후지산',
          'location': '시즈오카, 일본',
          'rating': '5.0',
          'status': '30명이 확인 중',
        },
      ],
      // 동남아시아 (index 2)
      [
        {
          'name': '앙코르 와트',
          'location': '씨엠립, 캄보디아',
          'rating': '5.0',
          'status': '22명이 확인 중',
        },
        {
          'name': '페트로나스 타워',
          'location': '쿠알라룸푸르, 말레이시아',
          'rating': '4.7',
          'status': '15명이 확인 중',
        },
        {
          'name': '부라나시리 해변',
          'location': '푸켓, 태국',
          'rating': '4.8',
          'status': '20명이 확인 중',
        },
        {
          'name': '보로부두르',
          'location': '족자카르타, 인도네시아',
          'rating': '4.6',
          'status': '10명이 확인 중',
        },
        {
          'name': '하롱베이',
          'location': '꽝닌, 베트남',
          'rating': '4.9',
          'status': '18명이 확인 중',
        },
      ],
      // 미국 (index 3)
      [
        {
          'name': '미국 서부 투어',
          'location': 'LA, 샌프란시스코',
          'rating': '4.7',
          'status': '5명이 예약 중',
          'price': '₩2,199,000',
          'originalPrice': '₩2,599,000',
        },
        {
          'name': '뉴욕 시티 투어',
          'location': '뉴욕',
          'rating': '4.8',
          'status': '15명이 예약 중',
          'price': '₩1,899,000',
          'originalPrice': '₩2,299,000',
        },
        {
          'name': '그랜드 캐니언 투어',
          'location': '애리조나',
          'rating': '5.0',
          'status': '8명이 예약 중',
          'price': '₩1,599,000',
          'originalPrice': '₩1,999,000',
        },
        {
          'name': '플로리다 올랜도',
          'location': '올랜도',
          'rating': '4.6',
          'status': '12명이 예약 중',
          'price': '₩1,799,000',
          'originalPrice': '₩2,199,000',
        },
        {
          'name': '옐로스톤 국립공원',
          'location': '와이오밍',
          'rating': '4.9',
          'status': '6명이 예약 중',
          'price': '₩2,399,000',
          'originalPrice': '₩2,799,000',
        },
      ],
      // 유럽 (index 4)
      [
        {
          'name': '유럽 5개국 투어',
          'location': '파리, 로마, 런던',
          'rating': '4.9',
          'status': '20명이 예약 중',
          'price': '₩2,599,000',
          'originalPrice': '₩2,999,000',
        },
        {
          'name': '파리 로맨틱 투어',
          'location': '파리, 프랑스',
          'rating': '4.8',
          'status': '15명이 예약 중',
          'price': '₩1,799,000',
          'originalPrice': '₩2,199,000',
        },
        {
          'name': '이탈리아 예술 투어',
          'location': '로마, 피렌체, 베네치아',
          'rating': '4.7',
          'status': '10명이 예약 중',
          'price': '₩2,199,000',
          'originalPrice': '₩2,599,000',
        },
        {
          'name': '그리스 산토리니',
          'location': '아테네, 산토리니',
          'rating': '5.0',
          'status': '18명이 예약 중',
          'price': '₩1,999,000',
          'originalPrice': '₩2,399,000',
        },
        {
          'name': '독일 로맨틱 가도',
          'location': '뮌헨, 노이슈반슈타인',
          'rating': '4.8',
          'status': '12명이 예약 중',
          'price': '₩1,899,000',
          'originalPrice': '₩2,299,000',
        },
      ],
      // 중국 (index 5)
      [
        {
          'name': '중국 골든 루트',
          'location': '베이징, 상하이',
          'rating': '4.6',
          'status': '25명이 예약 중',
          'price': '₩899,000',
          'originalPrice': '₩1,199,000',
        },
        {
          'name': '만리장성 투어',
          'location': '베이징',
          'rating': '4.7',
          'status': '20명이 예약 중',
          'price': '₩799,000',
          'originalPrice': '₩999,000',
        },
        {
          'name': '시안 병마용 투어',
          'location': '시안',
          'rating': '4.8',
          'status': '15명이 예약 중',
          'price': '₩699,000',
          'originalPrice': '₩899,000',
        },
        {
          'name': '장가계 자연 투어',
          'location': '장가계',
          'rating': '4.5',
          'status': '8명이 예약 중',
          'price': '₩999,000',
          'originalPrice': '₩1,299,000',
        },
        {
          'name': '청두 판다 투어',
          'location': '청두',
          'rating': '4.9',
          'status': '12명이 예약 중',
          'price': '₩799,000',
          'originalPrice': '₩999,000',
        },
      ],
      // 인도 (index 6)
      [
        {
          'name': '골든 트라이앵글',
          'location': '델리, 아그라, 자이푸르',
          'rating': '4.8',
          'status': '18명이 예약 중',
          'price': '₩1,299,000',
          'originalPrice': '₩1,599,000',
        },
        {
          'name': '타지마할 투어',
          'location': '아그라',
          'rating': '5.0',
          'status': '22명이 예약 중',
          'price': '₩899,000',
          'originalPrice': '₩1,199,000',
        },
        {
          'name': '케랄라 백워터',
          'location': '케랄라',
          'rating': '4.7',
          'status': '10명이 예약 중',
          'price': '₩1,199,000',
          'originalPrice': '₩1,499,000',
        },
        {
          'name': '라자스탄 궁전 투어',
          'location': '라자스탄',
          'rating': '4.6',
          'status': '6명이 예약 중',
          'price': '₩1,399,000',
          'originalPrice': '₩1,699,000',
        },
        {
          'name': '고아 비치 투어',
          'location': '고아',
          'rating': '4.9',
          'status': '15명이 예약 중',
          'price': '₩999,000',
          'originalPrice': '₩1,299,000',
        },
      ],
      // 호주 (index 7)
      [
        {
          'name': '호주 동부 투어',
          'location': '시드니, 멜버른',
          'rating': '4.8',
          'status': '16명이 예약 중',
          'price': '₩2,199,000',
          'originalPrice': '₩2,599,000',
        },
        {
          'name': '울루루 사막 투어',
          'location': '울루루',
          'rating': '4.9',
          'status': '8명이 예약 중',
          'price': '₩1,899,000',
          'originalPrice': '₩2,299,000',
        },
        {
          'name': '골드코스트 서핑',
          'location': '골드코스트',
          'rating': '4.7',
          'status': '12명이 예약 중',
          'price': '₩1,599,000',
          'originalPrice': '₩1,999,000',
        },
        {
          'name': '그레이트 배리어 리프',
          'location': '퀸즐랜드',
          'rating': '5.0',
          'status': '10명이 예약 중',
          'price': '₩2,399,000',
          'originalPrice': '₩2,799,000',
        },
        {
          'name': '퍼스 자연 투어',
          'location': '퍼스',
          'rating': '4.6',
          'status': '5명이 예약 중',
          'price': '₩1,799,000',
          'originalPrice': '₩2,199,000',
        },
      ],
      // 캐나다 (index 8)
      [
        {
          'name': '캐나다 동부 투어',
          'location': '토론토, 몬트리올',
          'rating': '4.7',
          'status': '14명이 예약 중',
          'price': '₩2,099,000',
          'originalPrice': '₩2,499,000',
        },
        {
          'name': '나이아가라 폭포',
          'location': '나이아가라',
          'rating': '4.8',
          'status': '20명이 예약 중',
          'price': '₩1,699,000',
          'originalPrice': '₩2,099,000',
        },
        {
          'name': '밴프 국립공원',
          'location': '앨버타',
          'rating': '5.0',
          'status': '12명이 예약 중',
          'price': '₩2,199,000',
          'originalPrice': '₩2,599,000',
        },
        {
          'name': '밴쿠버 도시 투어',
          'location': '밴쿠버',
          'rating': '4.6',
          'status': '8명이 예약 중',
          'price': '₩1,899,000',
          'originalPrice': '₩2,299,000',
        },
        {
          'name': '로키산맥 트레킹',
          'location': '로키산맥',
          'rating': '4.9',
          'status': '6명이 예약 중',
          'price': '₩2,399,000',
          'originalPrice': '₩2,799,000',
        },
      ],
      // 브라질 (index 9)
      [
        {
          'name': '브라질 하이라이트',
          'location': '리우, 상파울루',
          'rating': '4.8',
          'status': '10명이 예약 중',
          'price': '₩2,599,000',
          'originalPrice': '₩2,999,000',
        },
        {
          'name': '이과수 폭포 투어',
          'location': '이과수',
          'rating': '5.0',
          'status': '15명이 예약 중',
          'price': '₩1,999,000',
          'originalPrice': '₩2,399,000',
        },
        {
          'name': '아마존 정글 투어',
          'location': '마나우스',
          'rating': '4.7',
          'status': '6명이 예약 중',
          'price': '₩2,199,000',
          'originalPrice': '₩2,599,000',
        },
        {
          'name': '리우 카니발',
          'location': '리우데자네이루',
          'rating': '4.9',
          'status': '20명이 예약 중',
          'price': '₩2,799,000',
          'originalPrice': '₩3,199,000',
        },
        {
          'name': '살바도르 문화 투어',
          'location': '살바도르',
          'rating': '4.6',
          'status': '8명이 예약 중',
          'price': '₩1,799,000',
          'originalPrice': '₩2,199,000',
        },
      ],
    ];

    final destinations = destinationsByCategory[_selectedCategoryIndex];
    final destination = destinations[index % destinations.length];

    return Container(
      width: 257,
      margin: EdgeInsets.only(right: index < 4 ? 16 : 0),
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
            height: 182,
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
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 정보 섹션
          Padding(
            padding: const EdgeInsets.all(10), // 패딩을 12에서 10으로 줄임
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        destination['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0F1A2A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          destination['rating'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F1A2A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  destination['location'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12), // 16에서 12로 줄임
                Text(
                  destination['status'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C4DDC),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPackages() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '최근 업데이트 된 여행 패키지',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F1A2A),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TravelPackagesScreen(),
                    ),
                  );
                },
                child: const Text(
                  '전체 보기',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4C4DDC),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => _buildPackageCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(int index) {
    // 카테고리별 패키지 데이터
    final packagesByCategory = [
      // 스페인 (index 0)
      [
        {
          'name': '스페인 완전정복',
          'location': '바르셀로나, 마드리드',
          'rating': '5.0',
          'status': 'N명이 예약 중',
          'price': '₩1,299,000',
          'originalPrice': '₩1,599,000',
        },
        {
          'name': '바르셀로나 가우디 투어',
          'location': '바르셀로나',
          'rating': '4.9',
          'status': '8명이 예약 중',
          'price': '₩899,000',
          'originalPrice': '₩1,199,000',
        },
        {
          'name': '마드리드 & 톨레도',
          'location': '마드리드, 톨레도',
          'rating': '4.8',
          'status': '12명이 예약 중',
          'price': '₩799,000',
          'originalPrice': '₩999,000',
        },
        {
          'name': '스페인 남부 투어',
          'location': '세비야, 그라나다',
          'rating': '4.7',
          'status': '5명이 예약 중',
          'price': '₩1,099,000',
          'originalPrice': '₩1,399,000',
        },
        {
          'name': '플라멩코 체험',
          'location': '마드리드',
          'rating': '4.9',
          'status': '15명이 예약 중',
          'price': '₩599,000',
          'originalPrice': '₩799,000',
        },
      ],
      // 일본 (index 1)
      [
        {
          'name': '일본 벚꽃 투어',
          'location': '도쿄, 오사카, 교토',
          'rating': '4.9',
          'status': '12명이 예약 중',
          'price': '₩899,000',
          'originalPrice': '₩1,199,000',
        },
        {
          'name': '도쿄 디즈니랜드',
          'location': '도쿄',
          'rating': '4.8',
          'status': '25명이 예약 중',
          'price': '₩699,000',
          'originalPrice': '₩899,000',
        },
        {
          'name': '교토 전통 체험',
          'location': '교토',
          'rating': '4.7',
          'status': '8명이 예약 중',
          'price': '₩799,000',
          'originalPrice': '₩999,000',
        },
        {
          'name': '오사카 먹거리 투어',
          'location': '오사카',
          'rating': '4.9',
          'status': '18명이 예약 중',
          'price': '₩599,000',
          'originalPrice': '₩799,000',
        },
        {
          'name': '후지산 등반',
          'location': '시즈오카',
          'rating': '4.6',
          'status': '6명이 예약 중',
          'price': '₩1,199,000',
          'originalPrice': '₩1,499,000',
        },
      ],
      // 동남아시아 (index 2)
      [
        {
          'name': '동남아 힐링',
          'location': '발리, 푸켓',
          'rating': '4.8',
          'status': '8명이 예약 중',
          'price': '₩599,000',
          'originalPrice': '₩799,000',
        },
        {
          'name': '앙코르 와트 탐험',
          'location': '씨엠립',
          'rating': '5.0',
          'status': '12명이 예약 중',
          'price': '₩799,000',
          'originalPrice': '₩999,000',
        },
        {
          'name': '말레이시아 쿠알라룸푸르',
          'location': '쿠알라룸푸르',
          'rating': '4.7',
          'status': '5명이 예약 중',
          'price': '₩499,000',
          'originalPrice': '₩699,000',
        },
        {
          'name': '태국 방콕 & 파타야',
          'location': '방콕, 파타야',
          'rating': '4.6',
          'status': '20명이 예약 중',
          'price': '₩699,000',
          'originalPrice': '₩899,000',
        },
        {
          'name': '베트남 하롱베이',
          'location': '하노이, 하롱베이',
          'rating': '4.8',
          'status': '15명이 예약 중',
          'price': '₩599,000',
          'originalPrice': '₩799,000',
        },
      ],
      // 미국 (index 3)
      [
        {
          'name': '미국 서부 투어',
          'location': 'LA, 샌프란시스코',
          'rating': '4.7',
          'status': '5명이 예약 중',
          'price': '₩2,199,000',
          'originalPrice': '₩2,599,000',
        },
        {
          'name': '뉴욕 시티 투어',
          'location': '뉴욕',
          'rating': '4.8',
          'status': '15명이 예약 중',
          'price': '₩1,899,000',
          'originalPrice': '₩2,299,000',
        },
        {
          'name': '그랜드 캐니언 투어',
          'location': '애리조나',
          'rating': '5.0',
          'status': '8명이 예약 중',
          'price': '₩1,599,000',
          'originalPrice': '₩1,999,000',
        },
        {
          'name': '플로리다 올랜도',
          'location': '올랜도',
          'rating': '4.6',
          'status': '12명이 예약 중',
          'price': '₩1,799,000',
          'originalPrice': '₩2,199,000',
        },
        {
          'name': '옐로스톤 국립공원',
          'location': '와이오밍',
          'rating': '4.9',
          'status': '6명이 예약 중',
          'price': '₩2,399,000',
          'originalPrice': '₩2,799,000',
        },
      ],
      // 유럽 (index 4)
      [
        {
          'name': '유럽 5개국 투어',
          'location': '파리, 로마, 런던',
          'rating': '4.9',
          'status': '20명이 예약 중',
          'price': '₩2,599,000',
          'originalPrice': '₩2,999,000',
        },
        {
          'name': '파리 로맨틱 투어',
          'location': '파리, 프랑스',
          'rating': '4.8',
          'status': '15명이 예약 중',
          'price': '₩1,799,000',
          'originalPrice': '₩2,199,000',
        },
        {
          'name': '이탈리아 예술 투어',
          'location': '로마, 피렌체, 베네치아',
          'rating': '4.7',
          'status': '10명이 예약 중',
          'price': '₩2,199,000',
          'originalPrice': '₩2,599,000',
        },
        {
          'name': '그리스 산토리니',
          'location': '아테네, 산토리니',
          'rating': '5.0',
          'status': '18명이 예약 중',
          'price': '₩1,999,000',
          'originalPrice': '₩2,399,000',
        },
        {
          'name': '독일 로맨틱 가도',
          'location': '뮌헨, 노이슈반슈타인',
          'rating': '4.8',
          'status': '12명이 예약 중',
          'price': '₩1,899,000',
          'originalPrice': '₩2,299,000',
        },
      ],
      // 중국 (index 5)
      [
        {
          'name': '중국 골든 루트',
          'location': '베이징, 상하이',
          'rating': '4.6',
          'status': '25명이 예약 중',
          'price': '₩899,000',
          'originalPrice': '₩1,199,000',
        },
        {
          'name': '만리장성 투어',
          'location': '베이징',
          'rating': '4.7',
          'status': '20명이 예약 중',
          'price': '₩799,000',
          'originalPrice': '₩999,000',
        },
        {
          'name': '시안 병마용 투어',
          'location': '시안',
          'rating': '4.8',
          'status': '15명이 예약 중',
          'price': '₩699,000',
          'originalPrice': '₩899,000',
        },
        {
          'name': '장가계 자연 투어',
          'location': '장가계',
          'rating': '4.5',
          'status': '8명이 예약 중',
          'price': '₩999,000',
          'originalPrice': '₩1,299,000',
        },
        {
          'name': '청두 판다 투어',
          'location': '청두',
          'rating': '4.9',
          'status': '12명이 예약 중',
          'price': '₩799,000',
          'originalPrice': '₩999,000',
        },
      ],
      // 인도 (index 6)
      [
        {
          'name': '골든 트라이앵글',
          'location': '델리, 아그라, 자이푸르',
          'rating': '4.8',
          'status': '18명이 예약 중',
          'price': '₩1,299,000',
          'originalPrice': '₩1,599,000',
        },
        {
          'name': '타지마할 투어',
          'location': '아그라',
          'rating': '5.0',
          'status': '22명이 예약 중',
          'price': '₩899,000',
          'originalPrice': '₩1,199,000',
        },
        {
          'name': '케랄라 백워터',
          'location': '케랄라',
          'rating': '4.7',
          'status': '10명이 예약 중',
          'price': '₩1,199,000',
          'originalPrice': '₩1,499,000',
        },
        {
          'name': '라자스탄 궁전 투어',
          'location': '라자스탄',
          'rating': '4.6',
          'status': '6명이 예약 중',
          'price': '₩1,399,000',
          'originalPrice': '₩1,699,000',
        },
        {
          'name': '고아 비치 투어',
          'location': '고아',
          'rating': '4.9',
          'status': '15명이 예약 중',
          'price': '₩999,000',
          'originalPrice': '₩1,299,000',
        },
      ],
      // 호주 (index 7)
      [
        {
          'name': '호주 동부 투어',
          'location': '시드니, 멜버른',
          'rating': '4.8',
          'status': '16명이 예약 중',
          'price': '₩2,199,000',
          'originalPrice': '₩2,599,000',
        },
        {
          'name': '울루루 사막 투어',
          'location': '울루루',
          'rating': '4.9',
          'status': '8명이 예약 중',
          'price': '₩1,899,000',
          'originalPrice': '₩2,299,000',
        },
        {
          'name': '골드코스트 서핑',
          'location': '골드코스트',
          'rating': '4.7',
          'status': '12명이 예약 중',
          'price': '₩1,599,000',
          'originalPrice': '₩1,999,000',
        },
        {
          'name': '그레이트 배리어 리프',
          'location': '퀸즐랜드',
          'rating': '5.0',
          'status': '10명이 예약 중',
          'price': '₩2,399,000',
          'originalPrice': '₩2,799,000',
        },
        {
          'name': '퍼스 자연 투어',
          'location': '퍼스',
          'rating': '4.6',
          'status': '5명이 예약 중',
          'price': '₩1,799,000',
          'originalPrice': '₩2,199,000',
        },
      ],
      // 캐나다 (index 8)
      [
        {
          'name': '캐나다 동부 투어',
          'location': '토론토, 몬트리올',
          'rating': '4.7',
          'status': '14명이 예약 중',
          'price': '₩2,099,000',
          'originalPrice': '₩2,499,000',
        },
        {
          'name': '나이아가라 폭포',
          'location': '나이아가라',
          'rating': '4.8',
          'status': '20명이 예약 중',
          'price': '₩1,699,000',
          'originalPrice': '₩2,099,000',
        },
        {
          'name': '밴프 국립공원',
          'location': '앨버타',
          'rating': '5.0',
          'status': '12명이 예약 중',
          'price': '₩2,199,000',
          'originalPrice': '₩2,599,000',
        },
        {
          'name': '밴쿠버 도시 투어',
          'location': '밴쿠버',
          'rating': '4.6',
          'status': '8명이 예약 중',
          'price': '₩1,899,000',
          'originalPrice': '₩2,299,000',
        },
        {
          'name': '로키산맥 트레킹',
          'location': '로키산맥',
          'rating': '4.9',
          'status': '6명이 예약 중',
          'price': '₩2,399,000',
          'originalPrice': '₩2,799,000',
        },
      ],
      // 브라질 (index 9)
      [
        {
          'name': '브라질 하이라이트',
          'location': '리우, 상파울루',
          'rating': '4.8',
          'status': '10명이 예약 중',
          'price': '₩2,599,000',
          'originalPrice': '₩2,999,000',
        },
        {
          'name': '이과수 폭포 투어',
          'location': '이과수',
          'rating': '5.0',
          'status': '15명이 예약 중',
          'price': '₩1,999,000',
          'originalPrice': '₩2,399,000',
        },
        {
          'name': '아마존 정글 투어',
          'location': '마나우스',
          'rating': '4.7',
          'status': '6명이 예약 중',
          'price': '₩2,199,000',
          'originalPrice': '₩2,599,000',
        },
        {
          'name': '리우 카니발',
          'location': '리우데자네이루',
          'rating': '4.9',
          'status': '20명이 예약 중',
          'price': '₩2,799,000',
          'originalPrice': '₩3,199,000',
        },
        {
          'name': '살바도르 문화 투어',
          'location': '살바도르',
          'rating': '4.6',
          'status': '8명이 예약 중',
          'price': '₩1,799,000',
          'originalPrice': '₩2,199,000',
        },
      ],
    ];

    final packages = packagesByCategory[_selectedCategoryIndex];
    final package = packages[index % packages.length];

    return Container(
      width: 257,
      margin: EdgeInsets.only(right: index < 4 ? 16 : 0),
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
            height: 182,
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
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 정보 섹션
          Padding(
            padding: const EdgeInsets.all(10), // 패딩을 12에서 10으로 줄임
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        package['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0F1A2A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          package['rating'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F1A2A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  package['location'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12), // 16에서 12로 줄임
                Text(
                  package['status'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C4DDC),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomInfluencers() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '맞춤 트립인플루언서',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F1A2A),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InfluencersScreen(),
                    ),
                  );
                },
                child: const Text(
                  '전체 보기',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4C4DDC),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => _buildInfluencerCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfluencerCard(int index) {
    // 카테고리별 인플루언서 데이터
    final influencersByCategory = [
      // 스페인 (index 0)
      [
        {
          'name': '여행 작가 김OO',
          'location': '스페인 전문 가이드',
          'rating': '5.0',
          'status': 'N명이 상담 중',
        },
        {
          'name': '바르셀로나 가이드 박OO',
          'location': '바르셀로나 거주 10년',
          'rating': '4.9',
          'status': '8명이 상담 중',
        },
        {
          'name': '스페인어 통역사 이OO',
          'location': '마드리드 전문',
          'rating': '4.8',
          'status': '12명이 상담 중',
        },
        {
          'name': '플라멩코 강사 최OO',
          'location': '세비야 출신',
          'rating': '4.7',
          'status': '5명이 상담 중',
        },
        {
          'name': '건축 가이드 정OO',
          'location': '가우디 전문가',
          'rating': '4.9',
          'status': '15명이 상담 중',
        },
      ],
      // 일본 (index 1)
      [
        {
          'name': '트래블 유튜버 박OO',
          'location': '일본 현지 거주 5년',
          'rating': '4.9',
          'status': '8명이 상담 중',
        },
        {
          'name': '도쿄 가이드 김OO',
          'location': '도쿄 전문',
          'rating': '4.8',
          'status': '15명이 상담 중',
        },
        {
          'name': '일본어 통역사 이OO',
          'location': '오사카 거주 8년',
          'rating': '4.7',
          'status': '12명이 상담 중',
        },
        {
          'name': '교토 문화 가이드 최OO',
          'location': '교토 전통 전문',
          'rating': '5.0',
          'status': '20명이 상담 중',
        },
        {
          'name': '일본 요리 셰프 정OO',
          'location': '홋카이도 출신',
          'rating': '4.6',
          'status': '6명이 상담 중',
        },
      ],
      // 동남아시아 (index 2)
      [
        {
          'name': '여행 블로거 이OO',
          'location': '동남아 전문',
          'rating': '4.8',
          'status': '12명이 상담 중',
        },
        {
          'name': '태국 가이드 박OO',
          'location': '방콕 거주 7년',
          'rating': '4.7',
          'status': '18명이 상담 중',
        },
        {
          'name': '인도네시아 가이드 김OO',
          'location': '발리 전문',
          'rating': '4.9',
          'status': '10명이 상담 중',
        },
        {
          'name': '베트남 통역사 최OO',
          'location': '호치민 거주 6년',
          'rating': '4.6',
          'status': '8명이 상담 중',
        },
        {
          'name': '캄보디아 가이드 정OO',
          'location': '앙코르 와트 전문',
          'rating': '5.0',
          'status': '22명이 상담 중',
        },
      ],
      // 미국 (index 3)
      [
        {
          'name': '가이드 최OO',
          'location': '미국 서부 전문',
          'rating': '4.7',
          'status': '3명이 상담 중',
        },
        {
          'name': '뉴욕 가이드 김OO',
          'location': '뉴욕 거주 12년',
          'rating': '4.8',
          'status': '15명이 상담 중',
        },
        {
          'name': '로스앤젤레스 가이드 박OO',
          'location': 'LA 할리우드 전문',
          'rating': '4.6',
          'status': '8명이 상담 중',
        },
        {
          'name': '샌프란시스코 가이드 이OO',
          'location': '실리콘밸리 전문',
          'rating': '4.9',
          'status': '12명이 상담 중',
        },
        {
          'name': '플로리다 가이드 정OO',
          'location': '올랜도 디즈니 전문',
          'rating': '4.7',
          'status': '20명이 상담 중',
        },
      ],
      // 유럽 (index 4)
      [
        {
          'name': '파리 가이드 김OO',
          'location': '프랑스 문화 전문',
          'rating': '4.9',
          'status': '25명이 상담 중',
        },
        {
          'name': '이탈리아 가이드 박OO',
          'location': '로마 예술사 전공',
          'rating': '4.8',
          'status': '18명이 상담 중',
        },
        {
          'name': '독일 가이드 이OO',
          'location': '베를린 거주 8년',
          'rating': '4.7',
          'status': '12명이 상담 중',
        },
        {
          'name': '그리스 가이드 최OO',
          'location': '산토리니 전문',
          'rating': '5.0',
          'status': '20명이 상담 중',
        },
        {
          'name': '영국 가이드 정OO',
          'location': '런던 역사 전문',
          'rating': '4.6',
          'status': '15명이 상담 중',
        },
      ],
      // 중국 (index 5)
      [
        {
          'name': '중국어 통역사 김OO',
          'location': '베이징 거주 10년',
          'rating': '4.6',
          'status': '30명이 상담 중',
        },
        {
          'name': '상하이 가이드 박OO',
          'location': '상하이 현지인',
          'rating': '4.7',
          'status': '22명이 상담 중',
        },
        {
          'name': '만리장성 전문가 이OO',
          'location': '중국 역사 전문',
          'rating': '4.8',
          'status': '15명이 상담 중',
        },
        {
          'name': '시안 가이드 최OO',
          'location': '병마용 전문가',
          'rating': '4.5',
          'status': '10명이 상담 중',
        },
        {
          'name': '청두 가이드 정OO',
          'location': '판다 기지 전문',
          'rating': '4.9',
          'status': '18명이 상담 중',
        },
      ],
      // 인도 (index 6)
      [
        {
          'name': '인도 가이드 김OO',
          'location': '골든 트라이앵글 전문',
          'rating': '4.8',
          'status': '18명이 상담 중',
        },
        {
          'name': '타지마할 전문가 박OO',
          'location': '아그라 현지 가이드',
          'rating': '5.0',
          'status': '25명이 상담 중',
        },
        {
          'name': '케랄라 가이드 이OO',
          'location': '백워터 투어 전문',
          'rating': '4.7',
          'status': '12명이 상담 중',
        },
        {
          'name': '라자스탄 가이드 최OO',
          'location': '궁전 투어 전문',
          'rating': '4.6',
          'status': '8명이 상담 중',
        },
        {
          'name': '고아 가이드 정OO',
          'location': '비치 리조트 전문',
          'rating': '4.9',
          'status': '20명이 상담 중',
        },
      ],
      // 호주 (index 7)
      [
        {
          'name': '호주 가이드 김OO',
          'location': '시드니 거주 15년',
          'rating': '4.8',
          'status': '20명이 상담 중',
        },
        {
          'name': '멜버른 가이드 박OO',
          'location': '빅토리아 전문',
          'rating': '4.9',
          'status': '15명이 상담 중',
        },
        {
          'name': '골드코스트 가이드 이OO',
          'location': '서핑 전문가',
          'rating': '4.7',
          'status': '18명이 상담 중',
        },
        {
          'name': '울루루 가이드 최OO',
          'location': '원주민 문화 전문',
          'rating': '5.0',
          'status': '8명이 상담 중',
        },
        {
          'name': '퍼스 가이드 정OO',
          'location': '서호주 자연 전문',
          'rating': '4.6',
          'status': '12명이 상담 중',
        },
      ],
      // 캐나다 (index 8)
      [
        {
          'name': '캐나다 가이드 김OO',
          'location': '토론토 거주 12년',
          'rating': '4.7',
          'status': '16명이 상담 중',
        },
        {
          'name': '밴쿠버 가이드 박OO',
          'location': 'BC주 전문',
          'rating': '4.8',
          'status': '12명이 상담 중',
        },
        {
          'name': '나이아가라 가이드 이OO',
          'location': '폭포 투어 전문',
          'rating': '4.6',
          'status': '22명이 상담 중',
        },
        {
          'name': '로키산맥 가이드 최OO',
          'location': '국립공원 전문',
          'rating': '5.0',
          'status': '10명이 상담 중',
        },
        {
          'name': '몬트리올 가이드 정OO',
          'location': '프렌치 캐나다 전문',
          'rating': '4.9',
          'status': '14명이 상담 중',
        },
      ],
      // 브라질 (index 9)
      [
        {
          'name': '브라질 가이드 김OO',
          'location': '리우 거주 8년',
          'rating': '4.8',
          'status': '14명이 상담 중',
        },
        {
          'name': '이과수 가이드 박OO',
          'location': '폭포 전문가',
          'rating': '5.0',
          'status': '18명이 상담 중',
        },
        {
          'name': '상파울루 가이드 이OO',
          'location': '도시 투어 전문',
          'rating': '4.6',
          'status': '12명이 상담 중',
        },
        {
          'name': '아마존 가이드 최OO',
          'location': '정글 투어 전문',
          'rating': '4.9',
          'status': '8명이 상담 중',
        },
        {
          'name': '살바도르 가이드 정OO',
          'location': '바히아 문화 전문',
          'rating': '4.7',
          'status': '16명이 상담 중',
        },
      ],
    ];

    final influencers = influencersByCategory[_selectedCategoryIndex];
    final influencer = influencers[index % influencers.length];

    return Container(
      width: 257,
      margin: EdgeInsets.only(right: index < 4 ? 16 : 0),
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
            height: 182,
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
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 정보 섹션
          Padding(
            padding: const EdgeInsets.all(10), // 패딩을 12에서 10으로 줄임
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        influencer['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0F1A2A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          influencer['rating'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F1A2A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  influencer['location'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12), // 16에서 12로 줄임
                Text(
                  influencer['status'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C4DDC),
                  ),
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
            // Home (Active)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
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
                      fontWeight: FontWeight.w500,
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
