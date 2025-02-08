import 'package:miu/services/base/config.dart';
import 'package:miu/services/post/post_service.dart';
import 'package:miu/widgets/profile/action_button.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final dynamic post;
  final Function loadData;

  const ActionButtons({
    Key? key,
    required this.post,
    required this.loadData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ActionButton(
          icon: Icons.thumb_up,
          count: post['likeCount'] ?? 0,
          isActive: post['isLiked'] ?? false,
          onPressed: () async {
            await PostService(Config()).likePost(post['_id']);
            loadData();
          },
        ),
        ActionButton(
          icon: Icons.comment,
          count: post['commentCount'] ?? 0,
          isActive: false,
          onPressed: () async {
            await PostService(Config())
                .commentOnPost(post['id'], post['content']);
            loadData();
          },
        ),
        ActionButton(
          icon: Icons.repeat,
          count: post['retweetCount'] ?? 0,
          isActive: post['isRetweeted'] ?? false,
          onPressed: () async {
            await PostService(Config()).retweetPost(post['_id']);
            loadData();
          },
        ),
      ],
    );
  }
}
