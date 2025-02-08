import 'package:miu/services/image/image_service.dart';
import 'package:miu/widgets/user/action_buttons.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final dynamic post;
  final dynamic originalUser;
  final ImageService imageService;
  final Function loadData;

  const PostCard({
    Key? key,
    required this.post,
    required this.originalUser,
    required this.imageService,
    required this.loadData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post['isRetweeted'] == true)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.repeat, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'Retweetledi',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: originalUser['profileImageUrl'] != null
                      ? NetworkImage(imageService
                          .getFullImageUrl(originalUser['profileImageUrl']))
                      : null,
                  child: originalUser['profileImageUrl'] == null
                      ? Text(
                          originalUser['username'][0].toString().toUpperCase())
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  originalUser['username'] ?? 'Kullanıcı',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              post['isRetweeted']
                  ? post['originalPost']['content']
                  : post['content'],
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            ActionButtons(
              post: post,
              loadData: loadData,
            ),
          ],
        ),
      ),
    );
  }
}
