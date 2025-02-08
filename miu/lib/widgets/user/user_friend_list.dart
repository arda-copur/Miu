import 'package:miu/services/image/image_service.dart';
import 'package:miu/utils/theme/app_theme.dart';
import 'package:miu/views/user_profile.dart';
import 'package:flutter/material.dart';

class UserFriendsList extends StatelessWidget {
  final List<dynamic> friendsList;
  final String userId;

  UserFriendsList({
    Key? key,
    required this.friendsList,
    required this.userId,
  }) : super(key: key);

  final String userFriendsText = 'Arkadaşları';
  final String notYetFriendText = 'Henüz arkadaşı yok.';
  final ImageService imageService = ImageService();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppTheme.highPadding,
          child: Text(
            userFriendsText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        if (friendsList.isEmpty)
          Padding(
            padding: AppTheme.highPadding,
            child: Text(notYetFriendText),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friendsList.length,
            itemBuilder: (context, index) {
              final friend = friendsList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: friend['profileImageUrl'] != null
                      ? NetworkImage(imageService
                          .getFullImageUrl(friend['profileImageUrl']))
                      : null,
                  child: friend['profileImageUrl'] == null
                      ? Text((friend['username'] ?? 'U')[0].toUpperCase())
                      : null,
                ),
                title: Text(friend['username'] ?? ''),
                subtitle: Text(friend['email'] ?? ''),
                onTap: () {
                  if (friend['userId'] != userId) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserProfileView(userId: friend['userId']),
                      ),
                    );
                  }
                },
              );
            },
          ),
      ],
    );
  }
}
