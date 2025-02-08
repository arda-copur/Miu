import 'package:miu/services/image/image_service.dart';
import 'package:miu/widgets/user/post_card.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  final List<dynamic> userPosts;
  final ImageService imageService;
  final Function loadData;

  const PostList({
    Key? key,
    required this.userPosts,
    required this.imageService,
    required this.loadData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Paylaşımlar ve Retweetler',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: userPosts.length,
          itemBuilder: (context, index) {
            var post = userPosts[index];
            final originalUser = post['isRetweeted']
                ? post['originalPost']['userId']
                : post['userId'];

            return PostCard(
              post: post,
              originalUser: originalUser,
              imageService: imageService,
              loadData: loadData,
            );
          },
        ),
      ],
    );
  }
}
