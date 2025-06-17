final sampleUsers = [
  {
    "uid": "user_123",
    "nickname": "재성구리",
    "profileImage": "https://example.com/profile1.jpg",
    "joinedAt": "2024-06-01T12:00:00Z",
    "tripCount": 5,
    "daysWithService": 125
  },
  {
    "uid": "user_456",
    "nickname": "여행러버",
    "profileImage": "https://example.com/profile2.jpg",
    "joinedAt": "2024-05-10T09:00:00Z",
    "tripCount": 2,
    "daysWithService": 30
  },
];

final sampleTrips = [
  {
    "tripId": "trip_001",
    "userId": "user_123",
    "title": "도쿄 10대 맛집 뿌수기",
    "location": "일본 도쿄",
    "duration": "2박 3일",
    "startDate": "2025-03-18",
    "endDate": "2025-03-20",
    "tags": ["#친구와", "#힐링 여행", "#맛집 투어"],
    "cities": 1,
    "createdAt": "2024-06-01T12:00:00Z"
  },
];

final samplePackages = [
  {
    "packageId": "pkg_001",
    "title": "도쿄 패키지",
    "description": "도쿄 주요 명소와 맛집 투어 포함",
    "price": 299000,
    "imageUrl": "https://example.com/package1.jpg",
    "createdAt": "2024-06-01T12:00:00Z"
  },
];

final sampleRecommendations = [
  {
    "recommendationId": "rec_001",
    "userId": "user_123",
    "content": "이 맛집은 꼭 가보세요!",
    "createdAt": "2024-06-01T12:00:00Z"
  },
];

final sampleLikes = [
  {
    "likeId": "like_001",
    "userId": "user_123",
    "targetId": "trip_001",
    "targetType": "trip",
    "createdAt": "2024-06-01T12:00:00Z"
  },
];

final samplePosts = [
  {
    "postId": "post_001",
    "userId": "user_123",
    "title": "도쿄 여행 후기",
    "content": "정말 즐거운 여행이었어요!",
    "imageUrl": "https://example.com/post1.jpg",
    "createdAt": "2024-06-01T12:00:00Z"
  },
];

final sampleSchedules = [
  {
    "scheduleId": "sch_001",
    "tripId": "trip_001",
    "title": "1일차 일정",
    "description": "도쿄타워 방문 및 맛집 투어",
    "date": "2025-03-18",
    "places": ["도쿄타워", "스시집"],
    "createdAt": "2024-06-01T12:00:00Z"
  },
]; 