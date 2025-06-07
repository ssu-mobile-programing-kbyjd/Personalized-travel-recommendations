class RecommendationModel {
  final String recommendationId;
  final String userId;
  final String content;
  final DateTime createdAt;

  RecommendationModel({
    required this.recommendationId,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) => RecommendationModel(
        recommendationId: json['recommendationId'],
        userId: json['userId'],
        content: json['content'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'recommendationId': recommendationId,
        'userId': userId,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
      };
} 