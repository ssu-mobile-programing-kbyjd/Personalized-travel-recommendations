import '../models/influencer_model.dart';

class InfluencersDataSource {
  static final Map<String, List<InfluencerModel>> _influencersByCategory = {
    '스페인': [
      InfluencerModel(
        name: '여행 작가 김OO',
        location: '스페인 전문 가이드',
        rating: '5.0',
        status: 'N명이 상담 중',
        hasButton: true,
        category: '스페인',
      ),
      InfluencerModel(
        name: '바르셀로나 가이드 박OO',
        location: '바르셀로나 거주 10년',
        rating: '4.9',
        status: '8명이 상담 중',
        hasButton: true,
        category: '스페인',
      ),
      InfluencerModel(
        name: '스페인어 통역사 이OO',
        location: '마드리드 전문',
        rating: '4.8',
        status: '12명이 상담 중',
        hasButton: true,
        category: '스페인',
      ),
      InfluencerModel(
        name: '플라멩코 강사 최OO',
        location: '세비야 출신',
        rating: '4.7',
        status: '5명이 상담 중',
        hasButton: true,
        category: '스페인',
      ),
    ],
    '일본': [
      InfluencerModel(
        name: '트래블 유튜버 박OO',
        location: '일본 현지 거주 5년',
        rating: '4.9',
        status: '8명이 상담 중',
        hasButton: true,
        category: '일본',
      ),
      InfluencerModel(
        name: '도쿄 가이드 김OO',
        location: '도쿄 전문',
        rating: '4.8',
        status: '15명이 상담 중',
        hasButton: true,
        category: '일본',
      ),
      InfluencerModel(
        name: '일본어 통역사 이OO',
        location: '오사카 거주 8년',
        rating: '4.7',
        status: '12명이 상담 중',
        hasButton: true,
        category: '일본',
      ),
      InfluencerModel(
        name: '교토 문화 가이드 최OO',
        location: '교토 전통 전문',
        rating: '5.0',
        status: '20명이 상담 중',
        hasButton: true,
        category: '일본',
      ),
    ],
    // ... (동남아시아, 미국, 유럽, 중국, 인도, 호주, 캐나다, 브라질) 동일하게 추가 ...
  };

  static List<String> get categories => _influencersByCategory.keys.toList();

  static List<InfluencerModel> getInfluencersByCategory(String category) {
    return _influencersByCategory[category] ?? [];
  }
} 