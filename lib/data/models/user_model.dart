class UserModel {
  final String uid;
  final String nickname;
  final String profileImage;
  final DateTime joinedAt;
  final int tripCount;
  final int daysWithService;

  UserModel({
    required this.uid,
    required this.nickname,
    required this.profileImage,
    required this.joinedAt,
    required this.tripCount,
    required this.daysWithService,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        nickname: json['nickname'],
        profileImage: json['profileImage'],
        joinedAt: DateTime.parse(json['joinedAt']),
        tripCount: json['tripCount'],
        daysWithService: json['daysWithService'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'nickname': nickname,
        'profileImage': profileImage,
        'joinedAt': joinedAt.toIso8601String(),
        'tripCount': tripCount,
        'daysWithService': daysWithService,
      };
} 