import 'package:miu/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FriendList extends StatelessWidget {
  final List<dynamic> friendsList;
  final Function(String userId) onFriendTap;

  const FriendList({
    Key? key,
    required this.friendsList,
    required this.onFriendTap,
  }) : super(key: key);

  final String myFriendsText = 'Arkadaşlarım';
  final String notHasntFriendText = 'Henüz arkadaşınız yok.';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppTheme.primaryPadding,
          child: Text(myFriendsText,
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        if (friendsList.isEmpty)
          const Padding(
            padding: AppTheme.primaryPadding,
            child: Text(notHasntFriendText),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friendsList.length,
            itemBuilder: (context, index) {
              final friend = friendsList[index];

              final profileImageUrl = friend['profileImageUrl'];

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: profileImageUrl != null
                      ? NetworkImage(profileImageUrl)
                      : null,
                  child: profileImageUrl == null
                      ? Text((friend['username'] ?? 'U')[0].toUpperCase())
                      : null,
                ),
                title: Text(friend['username'] ?? ''),
                subtitle: Text(friend['email'] ?? ''),
                onTap: () => onFriendTap(friend['userId']),
              );
            },
          ),
      ],
    );
  }
}
