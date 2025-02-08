import 'package:miu/utils/theme/app_theme.dart';
import 'package:miu/widgets/profile/action_button.dart';
import 'package:flutter/material.dart';

class UserPostCard extends StatelessWidget {
  final String username;
  final String? profileImageUrl;
  final String content;
  final int likeCount;
  final int commentCount;
  final int retweetCount;
  final bool isLiked;
  final bool isRetweeted;
  final VoidCallback onLike;
  final VoidCallback onRetweet;

  const UserPostCard({
    Key? key,
    required this.username,
    this.profileImageUrl,
    required this.content,
    required this.likeCount,
    required this.commentCount,
    required this.retweetCount,
    required this.isLiked,
    required this.isRetweeted,
    required this.onLike,
    required this.onRetweet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: AppTheme.smallPadding,
      child: Padding(
        padding: AppTheme.smallPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isRetweeted)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.repeat, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'Retweetledin',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: profileImageUrl != null
                      ? NetworkImage(profileImageUrl!)
                      : null,
                  child: profileImageUrl == null
                      ? Text(
                          username.isNotEmpty ? username[0].toUpperCase() : '?')
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(content, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ActionButton(
                  icon: Icons.thumb_up,
                  count: likeCount,
                  isActive: isLiked,
                  onPressed: onLike,
                ),
                ActionButton(
                  icon: Icons.comment,
                  count: commentCount,
                  isActive: false,
                  onPressed: () {},
                ),
                ActionButton(
                  icon: Icons.repeat,
                  count: retweetCount,
                  isActive: isRetweeted,
                  onPressed: onRetweet,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
