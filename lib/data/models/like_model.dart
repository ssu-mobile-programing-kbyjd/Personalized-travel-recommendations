class LikeModel {
  final String likeId;
  final String userId;
  final String targetId;
  final String targetType;
  final DateTime createdAt;

  LikeModel({
    required this.likeId,
    required this.userId,
    required this.targetId,
    required this.targetType,
    required this.createdAt,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
        likeId: json['likeId'],
        userId: json['userId'],
        targetId: json['targetId'],
        targetType: json['targetType'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'likeId': likeId,
        'userId': userId,
        'targetId': targetId,
        'targetType': targetType,
        'createdAt': createdAt.toIso8601String(),
      };
} 