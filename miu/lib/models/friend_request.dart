import 'package:miu/models/user.dart';

class FriendRequest {
  final String id;
  final User from;
  final User to;
  final String status;
  final DateTime createdAt;

  FriendRequest({
    required this.id,
    required this.from,
    required this.to,
    required this.status,
    required this.createdAt,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      id: json['_id'] ?? json['id'] ?? '',
      from: User.fromJson(json['from'] ?? {}),
      to: User.fromJson(json['to'] ?? {}),
      status: json['status'] ?? 'pending',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
