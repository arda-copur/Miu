import 'package:miu/models/user.dart';

class Post {
  final String id;
  final String content;
  final User user;
  final DateTime createdAt;
  final int likeCount;
  final int commentCount;
  final int retweetCount;
  final bool isLiked;
  final bool isRetweeted;
  final Post? originalPost;

  Post({
    required this.id,
    required this.content,
    required this.user,
    required this.createdAt,
    this.likeCount = 0,
    this.commentCount = 0,
    this.retweetCount = 0,
    this.isLiked = false,
    this.isRetweeted = false,
    this.originalPost,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] ?? json['id'] ?? '',
      content: json['content'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      likeCount: json['likeCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      retweetCount: json['retweetCount'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      isRetweeted: json['isRetweeted'] ?? false,
      originalPost: json['originalPost'] != null
          ? Post.fromJson(json['originalPost'])
          : null,
    );
  }
}
