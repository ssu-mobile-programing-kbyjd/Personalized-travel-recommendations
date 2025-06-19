import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalized_travel_recommendations/data/datasources/travel_data.dart';

final Random _rand = Random();

List<String> nyLandmarks = [
  '센트럴 파크',
  '엠파이어 스테이트 빌딩',
  '자유의 여신상',
  '타임스퀘어',
  '메트로폴리탄 미술관',
];
List<String> nyLandmarkImages = [
  // 센트럴 파크
  'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
  // 엠파이어 스테이트 빌딩
  'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?auto=format&fit=crop&w=400&q=80',
  // 자유의 여신상
  'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
  // 타임스퀘어
  'https://upload.wikimedia.org/wikipedia/commons/4/47/New_york_times_square-terabass.jpg',
  // 메트로폴리탄 미술관
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
];
List<String> nyInfluencers = [
  'Alex Johnson',
  'Emily Smith',
  'Michael Lee',
  'Sophia Kim',
  'David Brown',
];
List<String> nyPackages = [
  '뉴욕 시티 익스플로러',
  '뉴욕 야경 투어',
  '브로드웨이 뮤지컬 패키지',
  '뉴욕 미술관 투어',
  '센트럴파크 피크닉',
];
List<String> nyPackageImages = [
  // 뉴욕 시티 익스플로러 (도시 전경)
  'https://blog-static.kkday.com/ko/blog/wp-content/uploads/Empire-State-Building_AShutterstock_421599727.jpg',
  // 뉴욕 야경 투어
  'https://images.unsplash.com/photo-1506377247377-2a5b3b417ebb?auto=format&fit=crop&w=400&q=80',
  // 브로드웨이 뮤지컬
  'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=400&q=80',
  // 뉴욕 미술관 투어 (메트로폴리탄)
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
  // 센트럴파크 피크닉
  'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
];

final List<Map<String, dynamic>> destinationsDummyData = [
  // 뉴욕 5개
  for (int i = 0; i < 5; i++)
    {
      'name': nyLandmarks[i],
      'location': '미국, 뉴욕',
      'category': '뉴욕',
      'image': nyLandmarkImages[i],
      'rating': double.parse((4.5 + i * 0.1).toStringAsFixed(1)),
      'isLiked': i % 2 == 0,
      'hits': _rand.nextInt(99) + 1,
    },
  // 나머지 도시 1개씩
  ...TravelData.countryCities.entries.expand((entry) => entry.value.where((city) => city != '뉴욕').map((city) => {
    'name': city + ' 랜드마크',
    'location': '${entry.key}, $city',
    'category': city,
    'image': 'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
    'rating': double.parse((4.0 + _rand.nextDouble() * 1.0).toStringAsFixed(1)),
    'isLiked': _rand.nextBool(),
    'hits': _rand.nextInt(99) + 1,
  })),
];

final List<Map<String, dynamic>> influencersDummyData = [
  // 뉴욕 5개
  for (int i = 0; i < 5; i++)
    {
      'name': nyInfluencers[i],
      'location': '미국, 뉴욕',
      'category': '뉴욕',
      'image': 'https://randomuser.me/api/portraits/${i % 2 == 0 ? 'men' : 'women'}/${11 + i}.jpg',
      'rating': double.parse((4.5 + i * 0.1).toStringAsFixed(1)),
      'isLiked': i % 2 == 1,
      'hits': _rand.nextInt(99) + 1,
    },
  // 나머지 도시 1개씩
  ...TravelData.countryCities.entries.expand((entry) => entry.value.where((city) => city != '뉴욕').map((city) => {
    'name': city + ' 인플루언서',
    'location': '${entry.key}, $city',
    'category': city,
    'image': 'https://randomuser.me/api/portraits/men/${_rand.nextInt(60)}.jpg',
    'rating': double.parse((4.0 + _rand.nextDouble() * 1.0).toStringAsFixed(1)),
    'isLiked': _rand.nextBool(),
    'hits': _rand.nextInt(99) + 1,
  })),
];

final List<Map<String, dynamic>> packagesDummyData = [
  // 뉴욕 5개
  for (int i = 0; i < 5; i++)
    {
      'name': nyPackages[i],
      'location': '미국, 뉴욕',
      'category': '뉴욕',
      'image': nyPackageImages[i],
      'price': 1200000 + i * 100000,
      'rating': double.parse((4.5 + i * 0.1).toStringAsFixed(1)),
      'isLiked': i % 2 == 0,
      'hits': _rand.nextInt(99) + 1,
    },
  // 나머지 도시 1개씩
  ...TravelData.countryCities.entries.expand((entry) => entry.value.where((city) => city != '뉴욕').map((city) => {
    'name': city + ' 여행 패키지',
    'location': '${entry.key}, $city',
    'category': city,
    'image': 'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
    'price': 1000000 + _rand.nextInt(10) * 100000,
    'rating': double.parse((4.0 + _rand.nextDouble() * 1.0).toStringAsFixed(1)),
    'isLiked': _rand.nextBool(),
    'hits': _rand.nextInt(99) + 1,
  })),
];

Future<void> uploadDummyData() async {
  final firestore = FirebaseFirestore.instance;

  // 기존 데이터 삭제
  print('기존 데이터 삭제 시작...');
  
  // destinations 컬렉션 삭제
  final destinationsSnapshot = await firestore.collection('destinations').get();
  for (var doc in destinationsSnapshot.docs) {
    await doc.reference.delete();
  }
  
  // influencers 컬렉션 삭제
  final influencersSnapshot = await firestore.collection('influencers').get();
  for (var doc in influencersSnapshot.docs) {
    await doc.reference.delete();
  }
  
  // packages 컬렉션 삭제
  final packagesSnapshot = await firestore.collection('packages').get();
  for (var doc in packagesSnapshot.docs) {
    await doc.reference.delete();
  }
  
  print('기존 데이터 삭제 완료');

  // 새로운 데이터 추가
  print('새로운 데이터 추가 시작...');

  // destinations
  for (final data in destinationsDummyData) {
    await firestore.collection('destinations').add(data);
  }
  // influencers
  for (final data in influencersDummyData) {
    await firestore.collection('influencers').add(data);
  }
  // packages
  for (final data in packagesDummyData) {
    await firestore.collection('packages').add(data);
  }
  
  print('새로운 데이터 추가 완료');
}