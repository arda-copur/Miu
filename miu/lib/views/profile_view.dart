import 'package:miu/services/base/config.dart';
import 'package:miu/services/image/image_service.dart';
import 'package:miu/services/post/post_service.dart';
import 'package:miu/utils/theme/app_theme.dart';
import 'package:miu/viewmodels/profile_view_model.dart';
import 'package:miu/views/user_profile.dart';
import 'package:miu/widgets/profile/camera_icon.dart';
import 'package:miu/widgets/profile/friend_list.dart';
import 'package:miu/widgets/profile/friend_request_card.dart';
import 'package:miu/widgets/profile/profile_avatar.dart';
import 'package:miu/widgets/profile/user_post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  final String? userId;

  const ProfileView({super.key, this.userId});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends ProfileViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: loadData,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error != null
                ? Center(child: Text(error!))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: AppTheme.primaryPadding,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<ImageService>()
                                      .showImageSourceDialog(context)
                                      .then((_) {
                                    fetchUserProfile();
                                  });
                                },
                                child: Stack(
                                  children: [
                                    ProfileAvatar(
                                      userData: userData,
                                    ),
                                    const CameraIcon()
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(userData?['username'] ?? usernameText,
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text(
                                userData?['email'] ?? emailText,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        if (friendRequests.isNotEmpty) ...[
                          Padding(
                            padding: AppTheme.smallPadding,
                            child: Text(
                              friendRequestsText,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: friendRequests.length,
                            itemBuilder: (context, index) {
                              var request = friendRequests[index];

                              return FriendRequestCard(
                                username:
                                    request['from']['username'] ?? userText,
                                email: request['from']['email'] ?? '',
                                profileImageUrl:
                                    request['from']['profileImageUrl'] != null
                                        ? imageService.getFullImageUrl(
                                            request['from']['profileImageUrl'])
                                        : null,
                                onAccept: () async {
                                  try {
                                    await friendService.acceptFriendRequest(
                                        request['from']['userId']);
                                    fetchFriendRequests();
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('İstek kabul edildi')),
                                      );
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(errorText)),
                                      );
                                    }
                                  }
                                },
                                onReject: () async {
                                  try {
                                    final success =
                                        await friendService.rejectFriendRequest(
                                            request['from']['userId']);

                                    if (success.data!) {
                                      await fetchFriendRequests();
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text(requestDismissText)),
                                        );
                                      }
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(requestErrorText)),
                                        );
                                      }
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Hata: ${e.toString()}')),
                                      );
                                    }
                                  }
                                },
                              );
                            },
                          ),
                        ],
                        FriendList(
                          friendsList: friendsList,
                          onFriendTap: (userId) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserProfileView(userId: userId),
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        Text(retweetsText,
                            style: Theme.of(context).textTheme.bodyMedium),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userPosts.length,
                          itemBuilder: (context, index) {
                            var post = userPosts[index];

                            final originalUser = post['isRetweeted']
                                ? post['originalPost']['userId']
                                : post['userId'];

                            return UserPostCard(
                              username: originalUser['username'] ?? 'Kullanıcı',
                              profileImageUrl:
                                  originalUser['profileImageUrl'] != null
                                      ? imageService.getFullImageUrl(
                                          originalUser['profileImageUrl'])
                                      : null,
                              content: post['content'],
                              likeCount: post['likeCount'] ?? 0,
                              commentCount: post['commentCount'] ?? 0,
                              retweetCount: post['retweetCount'] ?? 0,
                              isLiked: post['isLiked'] ?? false,
                              isRetweeted: post['isRetweeted'] ?? false,
                              onLike: () async {
                                await PostService(Config())
                                    .likePost(post['_id']);
                                fetchUserProfile();
                              },
                              onRetweet: () async {
                                await PostService(Config())
                                    .retweetPost(post['_id']);
                                fetchUserProfile();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
