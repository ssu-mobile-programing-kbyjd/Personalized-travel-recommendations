class TravelContentDataSource {
  static final List<Map<String, dynamic>> _contents = [
    {
      'title': '서울 속 골목 여행',
      'location': '서울',
      'tags': ['#로컬투어', '#도보여행', '#전통시장'],
      'image': 'https://images.unsplash.com/photo-1520880867055-1e30d1cb001c?auto=format&fit=crop&w=400&q=80',
      'description': '...',
      'isLiked': true,
    },
    {
      'title': '도쿄 벚꽃 명소 BEST 5',
      'location': '도쿄',
      'tags': ['#벚꽃', '#봄여행', '#공원산책'],
      'image': 'https://images.unsplash.com/photo-1520880867055-1e30d1cb001c?auto=format&fit=crop&w=400&q=80',
      'description': '''일본의 봄은 벚꽃과 함께 시작됩니다. 도쿄 도심 속 공원과 강변 벚꽃길을 따라 걷는 감성 산책 코스를 소개합니다. 사진 명소와 피크닉 팁도 함께 확인해보세요.''',
      'isLiked': false,
    },
    {
      'title': '파리 감성 카페 투어',
      'location': '파리',
      'tags': ['#감성여행', '#디저트', '#인스타감성'],
      'image': 'https://images.unsplash.com/photo-1520880867055-1e30d1cb001c?auto=format&fit=crop&w=400&q=80',
      'description': '''파리에서만 느낄 수 있는 고즈넉한 분위기의 감성 카페들을 소개합니다. 마카롱과 크루아상을 곁들인 브런치, 창밖으로 보이는 에펠탑 뷰까지 함께 즐겨보세요.''',
      'isLiked': true,
    },
    {
      'title': '오사카 시장 먹거리 탐방',
      'location': '오사카',
      'tags': ['#먹방', '#시장투어', '#야경'],
      'image': 'https://images.unsplash.com/photo-1544984243-ec57ea16a068?auto=format&fit=crop&w=400&q=80',
      'description': '''오사카의 대표 시장인 쿠로몬 시장과 도톤보리 골목에서 현지 먹거리를 즐겨보세요. 타코야끼, 오코노미야끼, 일본식 꼬치 등 길거리 음식 천국이 기다리고 있습니다.''',
      'isLiked': false,
    },
    {
      'title': '로마 고대 유적 가이드',
      'location': '로마',
      'tags': ['#역사', '#유적지', '#문화유산'],
      'image': 'https://images.unsplash.com/photo-1579600164511-2b4b1c5a83d7?auto=format&fit=crop&w=400&q=80',
      'description': '''콜로세움부터 포로 로마노, 트레비 분수까지 로마의 고대 유적지를 하루 안에 돌아보는 추천 루트! 입장 시간과 역사 배경도 함께 정리해드립니다.''',
      'isLiked': false,
    },
    {
      'title': '하와이 힐링 해변 여행',
      'location': '하와이',
      'tags': ['#휴양지', '#바다', '#드론샷'],
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=400&q=80',
      'description': '''하와이의 대표 해변 와이키키에서 여유로운 시간을 보내보세요. 서핑, 선셋 요가, 드론으로 담는 절경까지 휴양에 최적화된 여행 코스를 추천합니다.''',
      'isLiked': false,
    }
  ];

  static List<Map<String, dynamic>> getAllContents() {
    return _contents.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static void updateLikeStatus(String title, bool isLiked) {
    for (var item in _contents) {
      if (item['title'] == title) {
        item['isLiked'] = isLiked;
        break;
      }
    }
  }
}
