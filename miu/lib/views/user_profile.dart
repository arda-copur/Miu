import 'package:miu/utils/theme/app_theme.dart';
import 'package:miu/viewmodels/user_profile_view_model.dart';
import 'package:miu/widgets/user/friend_button.dart';
import 'package:miu/widgets/user/post_list.dart';
import 'package:miu/widgets/user/profile_photo.dart';
import 'package:miu/widgets/user/user_friend_list.dart';
import 'package:flutter/material.dart';

class UserProfileView extends StatefulWidget {
  final String userId;

  const UserProfileView({super.key, required this.userId});

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends UserProfileViewModel {
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (userProfile == null) {
      return Scaffold(
        body: Center(child: Text(userNotFoundText)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(userProfile![userName]),
      ),
      body: RefreshIndicator(
        onRefresh: loadData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppTheme.highPadding,
                child: Column(
                  children: [
                    ProfilePhoto(
                      userProfile: userProfile!,
                      imageService: imageService,
                    ),
                    const SizedBox(height: 20),
                    Text(userProfile![userName],
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text(userProfile![email],
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 20),
                    FriendButton(isFriend: isFriend, userId: widget.userId)
                  ],
                ),
              ),
              const Divider(),
              UserFriendsList(friendsList: friendsList, userId: widget.userId),
              const Divider(),
              PostList(
                  userPosts: userPosts,
                  imageService: imageService,
                  loadData: loadData)
            ],
          ),
        ),
      ),
    );
  }
}
