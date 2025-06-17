class PostModel {
  final String postId;
  final String userId;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;

  PostModel({
    required this.postId,
    required this.userId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        postId: json['postId'],
        userId: json['userId'],
        title: json['title'],
        content: json['content'],
        imageUrl: json['imageUrl'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'userId': userId,
        'title': title,
        'content': content,
        'imageUrl': imageUrl,
        'createdAt': createdAt.toIso8601String(),
      };
} 