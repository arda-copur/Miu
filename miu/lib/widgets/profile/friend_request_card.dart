import 'package:miu/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FriendRequestCard extends StatelessWidget {
  final String username;
  final String email;
  final String? profileImageUrl;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const FriendRequestCard({
    Key? key,
    required this.username,
    required this.email,
    this.profileImageUrl,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              profileImageUrl != null ? NetworkImage(profileImageUrl!) : null,
          child: profileImageUrl == null
              ? Text(username.isNotEmpty ? username[0].toUpperCase() : '?')
              : null,
        ),
        title: Text(username),
        subtitle: Text(email),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check, color: AppTheme.neutral2),
              onPressed: onAccept,
            ),
            IconButton(
              icon: const Icon(Icons.clear, color: AppTheme.neutral1),
              onPressed: onReject,
            ),
          ],
        ),
      ),
    );
  }
}
