import 'package:miu/services/base/config.dart';
import 'package:miu/services/post/post_service.dart';
import 'package:miu/services/status/status_service.dart';
import 'package:miu/utils/extensions/context_extension.dart';
import 'package:miu/utils/extensions/image_extension.dart';
import 'package:miu/utils/theme/app_theme.dart';
import 'package:miu/viewmodels/home_view_model.dart';
import 'package:miu/views/user_profile.dart';
import 'package:miu/widgets/home/create_post_button.dart';
import 'package:miu/widgets/home/custom_search_bar.dart';
import 'package:miu/widgets/home/home_drawer.dart';
import 'package:miu/widgets/home/posts_list.dart';
import 'package:miu/widgets/home/search_results_list.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(PngImageItems.miu.imagePath,
            height: context.dynamicHeight(0.08)),
        centerTitle: true,
        bottom: CustomSearchBar(
          searchQuery: searchQuery,
          onSearchQueryChanged: (value) {
            setState(() {
              searchQuery = value;
            });
            if (value.isNotEmpty) {
              searchUsers(value);
            } else {
              setState(() {
                searchedUsers = [];
              });
            }
          },
        ),
      ),
      drawer: HomeDrawer(
        onProfileTap: () {
          Navigator.pushNamed(context, '/profile');
        },
        onLogoutTap: () async {
          await Provider.of<StatusService>(context, listen: false).logout();
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('/login');
        },
      ),
      body: Column(
        children: [
          if (searchedUsers.isNotEmpty) ...[
            Padding(
              padding: AppTheme.smallPadding,
              child: Text(
                usersText,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SearchResultsList(
              searchedUsers: searchedUsers,
              onUserTap: (userId) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileView(userId: userId),
                  ),
                );
              },
            ),
          ],
          PostsList(
            posts: posts,
            onLike: (postId) async {
              await PostService(Config()).likePost(postId);
              setState(() {
                var post = posts.firstWhere((p) => p['_id'] == postId);
                post['isLiked'] = !post['isLiked'];
                post['likeCount'] = post['isLiked']
                    ? (post['likeCount'] + 1)
                    : (post['likeCount'] - 1);
              });
            },
            onRetweet: (postId) async {
              await PostService(Config()).retweetPost(postId);
              setState(() {
                var post = posts.firstWhere((p) => p['_id'] == postId);
                post['isRetweeted'] = !post['isRetweeted'];
                post['retweetCount'] = post['isRetweeted']
                    ? (post['retweetCount'] + 1)
                    : (post['retweetCount'] - 1);
              });
            },
            onComment: (postId) {
              showCommentDialog(postId);
            },
            getImageUrl: (String? imagePath) {
              return imageService.getFullImageUrl(imagePath);
            },
          ),
        ],
      ),
      floatingActionButton: CreatePostButton(
        onPostCreated: fetchPosts,
      ),
    );
  }
}
