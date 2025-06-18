class TravelPackagesDataSource {
  static const List<Map<String, dynamic>> packagesByCategory = [
    // 스페인 (index 0)
    {
      'name': '스페인 완전정복',
      'location': '바르셀로나, 마드리드',
      'rating': '5.0',
      'status': 'N명이 예약 중',
      'duration': '2박 3일',
      'originalPrice': '₩1,200,000',
      'price': '₩899,000',
      'category': '스페인',
    },
    {
      'name': '바르셀로나 가우디 투어',
      'location': '바르셀로나',
      'rating': '4.9',
      'status': '8명이 예약 중',
      'duration': '3박 4일',
      'originalPrice': '₩1,500,000',
      'price': '₩1,199,000',
      'category': '스페인',
    },
    {
      'name': '마드리드 & 톨레도',
      'location': '마드리드, 톨레도',
      'rating': '4.8',
      'status': '12명이 예약 중',
      'duration': '2박 3일',
      'originalPrice': '₩900,000',
      'price': '₩699,000',
      'category': '스페인',
    },
    {
      'name': '스페인 남부 투어',
      'location': '세비야, 그라나다',
      'rating': '4.7',
      'status': '5명이 예약 중',
      'duration': '3박 4일',
      'originalPrice': '₩1,300,000',
      'price': '₩999,000',
      'category': '스페인',
    },
    // 일본 (index 1)
    {
      'name': '일본 벚꽃 투어',
      'location': '도쿄, 오사카, 교토',
      'rating': '4.9',
      'status': '12명이 예약 중',
      'duration': '4박 5일',
      'originalPrice': '₩1,200,000',
      'price': '₩899,000',
      'category': '일본',
    },
    {
      'name': '도쿄 디즈니랜드',
      'location': '도쿄',
      'rating': '4.8',
      'status': '25명이 예약 중',
      'duration': '3박 4일',
      'originalPrice': '₩900,000',
      'price': '₩699,000',
      'category': '일본',
    },
    {
      'name': '교토 전통 체험',
      'location': '교토',
      'rating': '4.7',
      'status': '8명이 예약 중',
      'duration': '3박 4일',
      'originalPrice': '₩1,000,000',
      'price': '₩799,000',
      'category': '일본',
    },
    {
      'name': '오사카 먹거리 투어',
      'location': '오사카',
      'rating': '4.9',
      'status': '18명이 예약 중',
      'duration': '2박 3일',
      'originalPrice': '₩800,000',
      'price': '₩599,000',
      'category': '일본',
    },
    // 동남아시아 (index 2)
    {
      'name': '동남아 힐링',
      'location': '발리, 푸켓',
      'rating': '4.8',
      'status': '8명이 예약 중',
      'duration': '5박 6일',
      'originalPrice': '₩800,000',
      'price': '₩599,000',
      'category': '동남아시아',
    },
    {
      'name': '앙코르 와트 탐험',
      'location': '씨엠립',
      'rating': '5.0',
      'status': '12명이 예약 중',
      'duration': '3박 4일',
      'originalPrice': '₩1,000,000',
      'price': '₩799,000',
      'category': '동남아시아',
    },
    {
      'name': '말레이시아 쿠알라룸푸르',
      'location': '쿠알라룸푸르',
      'rating': '4.7',
      'status': '5명이 예약 중',
      'duration': '3박 4일',
      'originalPrice': '₩700,000',
      'price': '₩499,000',
      'category': '동남아시아',
    },
    {
      'name': '태국 방콕 & 파타야',
      'location': '방콕, 파타야',
      'rating': '4.6',
      'status': '20명이 예약 중',
      'duration': '4박 5일',
      'originalPrice': '₩900,000',
      'price': '₩699,000',
      'category': '동남아시아',
    },
    // 미국
    {
      'name': '미국 서부 투어',
      'location': 'LA, 샌프란시스코',
      'rating': '4.7',
      'status': '5명이 예약 중',
      'duration': '7박 8일',
      'originalPrice': '₩2,600,000',
      'price': '₩2,199,000',
      'category': '미국',
    },
    {
      'name': '뉴욕 시티 투어',
      'location': '뉴욕',
      'rating': '4.8',
      'status': '15명이 예약 중',
      'duration': '5박 6일',
      'originalPrice': '₩2,300,000',
      'price': '₩1,899,000',
      'category': '미국',
    },
    // 유럽
    {
      'name': '프랑스 파리 투어',
      'location': '파리',
      'rating': '4.9',
      'status': '25명이 예약 중',
      'duration': '5박 6일',
      'originalPrice': '₩1,800,000',
      'price': '₩1,399,000',
      'category': '유럽',
    },
    {
      'name': '이탈리아 로마 투어',
      'location': '로마, 플로렌스',
      'rating': '4.8',
      'status': '18명이 예약 중',
      'duration': '6박 7일',
      'originalPrice': '₩2,000,000',
      'price': '₩1,599,000',
      'category': '유럽',
    },
  ];

  static List<Map<String, dynamic>> getAllPackages() {
    return packagesByCategory;
  }

  static List<Map<String, dynamic>> getPackagesByCategory(String category) {
    return packagesByCategory
        .where((package) => package['category'] == category)
        .toList();
  }

  static List<String> getCategories() {
    return packagesByCategory
        .map((package) => package['category'] as String)
        .toSet()
        .toList();
  }
} 