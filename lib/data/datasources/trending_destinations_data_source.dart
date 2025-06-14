import '../models/trending_destination_model.dart';

class TrendingDestinationsDataSource {
  static final Map<String, List<TrendingDestinationModel>> _destinationsByCategory = {
    '스페인': [
      TrendingDestinationModel(
        name: '사그라다 파밀리아',
        location: '바르셀로나, 스페인',
        rating: '5.0',
        status: 'N명이 확인 중',
        hasButton: true,
        category: '스페인',
      ),
      TrendingDestinationModel(
        name: '카사 밀라',
        location: '바르셀로나, 스페인',
        rating: '5.0',
        status: '3명이 확인 중',
        hasButton: true,
        category: '스페인',
      ),
      TrendingDestinationModel(
        name: '구엘 공원',
        location: '바르셀로나, 스페인',
        rating: '4.8',
        status: '15명이 확인 중',
        hasButton: true,
        category: '스페인',
      ),
      TrendingDestinationModel(
        name: '라 페드레라',
        location: '바르셀로나, 스페인',
        rating: '4.9',
        status: '8명이 확인 중',
        hasButton: true,
        category: '스페인',
      ),
    ],
    '일본': [
      TrendingDestinationModel(
        name: '센소지 절',
        location: '도쿄, 일본',
        rating: '4.8',
        status: '25명이 확인 중',
        hasButton: true,
        category: '일본',
      ),
      TrendingDestinationModel(
        name: '후시미 이나리 신사',
        location: '교토, 일본',
        rating: '4.9',
        status: '18명이 확인 중',
        hasButton: true,
        category: '일본',
      ),
      TrendingDestinationModel(
        name: '오사카 성',
        location: '오사카, 일본',
        rating: '4.7',
        status: '12명이 확인 중',
        hasButton: true,
        category: '일본',
      ),
      TrendingDestinationModel(
        name: '후지산',
        location: '시즈오카, 일본',
        rating: '5.0',
        status: '30명이 확인 중',
        hasButton: true,
        category: '일본',
      ),
    ],
    // ... (동남아시아, 미국, 유럽, 중국, 인도, 호주, 캐나다, 브라질) 동일하게 추가 ...
  };

  static List<String> get categories => _destinationsByCategory.keys.toList();

  static List<TrendingDestinationModel> getDestinationsByCategory(String category) {
    return _destinationsByCategory[category] ?? [];
  }
} 