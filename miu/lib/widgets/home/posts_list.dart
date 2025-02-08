import 'package:flutter/material.dart';

class PostsList extends StatelessWidget {
  final List<dynamic> posts;
  final Function(String postId) onLike;
  final Function(String postId) onRetweet;
  final Function(String postId) onComment;
  final String Function(String?) getImageUrl;

  const PostsList({
    Key? key,
    required this.posts,
    required this.onLike,
    required this.onRetweet,
    required this.onComment,
    required this.getImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: posts.isEmpty
          ? const Center(child: Text('Henüz burada gösterilecek bir şey yok.'))
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                var post = posts[index];
                bool isLiked = post['isLiked'] ?? false;
                bool isRetweeted = post['isRetweeted'] ?? false;

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (post['retweetedBy'] != null &&
                            post['retweetedBy'].isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.repeat,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  '${post['retweetedBy'].join(", ")} retweetledi',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  post['userId']?['profileImageUrl'] != null
                                      ? NetworkImage(getImageUrl(
                                          post['userId']['profileImageUrl']))
                                      : null,
                              child: post['userId']?['profileImageUrl'] == null
                                  ? Text((post['userId']?['username'] ?? 'U')[0]
                                      .toUpperCase())
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              post['user']?['username'] ?? 'Bilinmeyen',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          post['content'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: isLiked ? Colors.red : Colors.grey,
                              ),
                              onPressed: () => onLike(post['_id']),
                            ),
                            Text('${post['likeCount']} beğeni'),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.messenger_outlined),
                              onPressed: () => onComment(post['_id']),
                            ),
                            Text('${post['commentCount']} yorum'),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: Icon(
                                Icons.repeat,
                                color: isRetweeted ? Colors.green : Colors.grey,
                              ),
                              onPressed: () => onRetweet(post['_id']),
                            ),
                            Text('${post['retweetCount']} paylaşım'),
                          ],
                        ),
                        if (post['comments'] != null &&
                            post['comments'].isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Yorumlar:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              ...post['comments']
                                  .map<Widget>(
                                    (comment) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundImage: comment['userId']
                                                        ?['profileImageUrl'] !=
                                                    null
                                                ? NetworkImage(getImageUrl(
                                                    comment['userId']
                                                        ['profileImageUrl']))
                                                : null,
                                            child: comment['userId']
                                                        ?['profileImageUrl'] ==
                                                    null
                                                ? Text((comment['userId']
                                                            ?['username'] ??
                                                        'U')[0]
                                                    .toUpperCase())
                                                : null,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  comment['user']
                                                          ?['username'] ??
                                                      'Bilinmeyen',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  comment['text'] ?? '',
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
