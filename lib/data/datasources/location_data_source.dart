class LocationDataSource {
  static const Map<String, Map<String, List<String>>> locationData = {
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

  static List<String> getContinents() {
    return locationData.keys.toList();
  }

  static List<String> getCountries(String continent) {
    return locationData[continent]?.keys.toList() ?? [];
  }

  static List<String> getCities(String continent, String country) {
    return locationData[continent]?[country] ?? [];
  }
} 