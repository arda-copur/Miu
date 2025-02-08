class User {
  final String id;
  final String username;
  final String email;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      profileImageUrl: json['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }
}
