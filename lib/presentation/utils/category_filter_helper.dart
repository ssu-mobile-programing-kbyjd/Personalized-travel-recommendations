class CategoryFilterHelper {
  static const List<String> _defaultIconList = [
    'Icons.house_outlined',
    'Icons.apartment_outlined',
    'Icons.business_outlined',
    'Icons.home_outlined',
    'Icons.location_city_outlined',
    'Icons.temple_buddhist_outlined',
    'Icons.temple_hindu_outlined',
    'Icons.waves_outlined',
    'Icons.forest_outlined',
    'Icons.sports_soccer_outlined',
  ];

  /// 카테고리 이름 리스트를 받아서 CategoryFilterWidget에서 사용할 수 있는 
  /// List<Map<String, dynamic>> 형태로 변환합니다.
  static List<Map<String, dynamic>> createCategoryFilters(List<String> categoryNames) {
    return categoryNames.asMap().entries.map((entry) => {
      'name': entry.value,
      'icon': entry.key < _defaultIconList.length 
          ? _defaultIconList[entry.key] 
          : 'Icons.place_outlined',
    }).toList();
  }

  /// 기본 여행 카테고리 목록을 반환합니다.
  static List<String> getDefaultTravelCategories() {
    return ['스페인', '일본', '동남아시아', '미국', '유럽', '중국', '인도', '호주', '캐나다', '브라질'];
  }

  /// 홈 화면용 간소화된 카테고리 목록을 반환합니다.
  static List<String> getHomeCategoryNames() {
    return ['스페인', '일본', '동남아시아', '유럽', '북미'];
  }
} 