class TravelPackagesDataSource {
  static const List<Map<String, dynamic>> packagesByCategory = [
    // 스페인
    {
      'name': '스페인 완전정복',
      'location': '바르셀로나, 마드리드',
      'rating': '5.0',
      'status': 'N명이 예약 중',
      'duration': '2박 3일',
      'originalPrice': '₩1,200,000',
      'price': '₩899,000',
      'category': '스페인',
      'tags': ['#인기', '#예약가능', '#문화탐방'],
      'image': 'https://cdn.pixabay.com/photo/2020/03/11/11/53/street-4921940_1280.jpg',
      'isLiked': true,
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
      'tags': ['#건축', '#가우디', '#예술'],
      'image': 'https://media.istockphoto.com/id/2153347966/ko/%EC%82%AC%EC%A7%84/eiffel-tower-in-paris-france-on-a-sunny-day.jpg?s=2048x2048&w=is&k=20&c=TtOuyu2Lgt_m2QMLROK36W-IMvEwKJ2mG-elf58YTnc=', //임시
      'isLiked': false,
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
      'tags': ['#역사', '#고성', '#투어'],
      'image': 'https://media.istockphoto.com/id/2153347966/ko/%EC%82%AC%EC%A7%84/eiffel-tower-in-paris-france-on-a-sunny-day.jpg?s=2048x2048&w=is&k=20&c=TtOuyu2Lgt_m2QMLROK36W-IMvEwKJ2mG-elf58YTnc=', //임시
      'isLiked': false,
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
      'tags': ['#남부', '#이슬람문화', '#세계유산'],
      'image': 'https://media.istockphoto.com/id/2153347966/ko/%EC%82%AC%EC%A7%84/eiffel-tower-in-paris-france-on-a-sunny-day.jpg?s=2048x2048&w=is&k=20&c=TtOuyu2Lgt_m2QMLROK36W-IMvEwKJ2mG-elf58YTnc=', //임시
      'isLiked': false,
    },

    // 일본
    {
      'name': '일본 벚꽃 투어',
      'location': '도쿄, 오사카, 교토',
      'rating': '4.9',
      'status': '12명이 예약 중',
      'duration': '4박 5일',
      'originalPrice': '₩1,200,000',
      'price': '₩899,000',
      'category': '일본',
      'tags': ['#벚꽃', '#봄추천', '#자연'],
      'image': 'https://media.istockphoto.com/id/1195370326/ko/%EC%82%AC%EC%A7%84/%EB%B4%84%EC%97%90%EB%8A%94-%EC%9D%BC%EB%B3%B8-%EC%A0%84%ED%86%B5-%EA%B8%B0%EB%AA%A8%EB%85%B8%EC%99%80-%EB%B2%9A%EA%BD%83%EC%9D%84-%EC%9E%85%EC%9D%80-%EC%95%84%EC%8B%9C%EC%95%84-%EC%97%AC%EC%84%B1.jpg?s=612x612&w=0&k=20&c=HJTlTUjdhRGLnB1rtT8Inje3U60qedOTzn4bxIzifUM=', //임시
      'isLiked': true,
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
      'tags': ['#가족여행', '#놀이공원', '#엔터테인먼트'],
      'image': 'https://media.istockphoto.com/id/2153347966/ko/%EC%82%AC%EC%A7%84/eiffel-tower-in-paris-france-on-a-sunny-day.jpg?s=2048x2048&w=is&k=20&c=TtOuyu2Lgt_m2QMLROK36W-IMvEwKJ2mG-elf58YTnc=', //임시
      'isLiked': false,
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
      'tags': ['#기모노', '#문화체험', '#전통'],
      'image': 'https://media.istockphoto.com/id/2153347966/ko/%EC%82%AC%EC%A7%84/eiffel-tower-in-paris-france-on-a-sunny-day.jpg?s=2048x2048&w=is&k=20&c=TtOuyu2Lgt_m2QMLROK36W-IMvEwKJ2mG-elf58YTnc=', //임시
      'isLiked': false,
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
      'tags': ['#먹방', '#시장투어', '#현지음식'],
      'image': 'https://media.istockphoto.com/id/2153347966/ko/%EC%82%AC%EC%A7%84/eiffel-tower-in-paris-france-on-a-sunny-day.jpg?s=2048x2048&w=is&k=20&c=TtOuyu2Lgt_m2QMLROK36W-IMvEwKJ2mG-elf58YTnc=', //임시
      'isLiked': false,
    },

    // 동남아시아
    {
      'name': '동남아 힐링',
      'location': '발리, 푸켓',
      'rating': '4.8',
      'status': '8명이 예약 중',
      'duration': '5박 6일',
      'originalPrice': '₩800,000',
      'price': '₩599,000',
      'category': '동남아시아',
      'tags': ['#휴양지', '#해변', '#마사지'],
      'image': 'https://cdn.pixabay.com/photo/2015/03/09/18/34/beach-666122_1280.jpg', //임시
      'isLiked': true,
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
      'tags': ['#사원탐방', '#역사', '#문화유산'],
      'image': 'https://media.istockphoto.com/id/2153347966/ko/%EC%82%AC%EC%A7%84/eiffel-tower-in-paris-france-on-a-sunny-day.jpg?s=2048x2048&w=is&k=20&c=TtOuyu2Lgt_m2QMLROK36W-IMvEwKJ2mG-elf58YTnc=', //임시
      'isLiked': false,
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
      'tags': ['#도시여행', '#야경', '#시장'],
      'image': 'https://media.istockphoto.com/id/2153347966/ko/%EC%82%AC%EC%A7%84/eiffel-tower-in-paris-france-on-a-sunny-day.jpg?s=2048x2048&w=is&k=20&c=TtOuyu2Lgt_m2QMLROK36W-IMvEwKJ2mG-elf58YTnc=', //임시
      'isLiked': false,
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
      'tags': ['#야시장', '#리조트', '#코끼리체험'],
      'image': 'https://media.istockphoto.com/id/2153347966/ko/%EC%82%AC%EC%A7%84/eiffel-tower-in-paris-france-on-a-sunny-day.jpg?s=2048x2048&w=is&k=20&c=TtOuyu2Lgt_m2QMLROK36W-IMvEwKJ2mG-elf58YTnc=', //임시
      'isLiked': false,
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