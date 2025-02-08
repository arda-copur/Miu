import 'package:flutter/material.dart';

class SearchResultsList extends StatelessWidget {
  final List<dynamic> searchedUsers;
  final Function(String userId) onUserTap;

  const SearchResultsList({
    Key? key,
    required this.searchedUsers,
    required this.onUserTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: searchedUsers.length,
        itemBuilder: (context, index) {
          var user = searchedUsers[index];
          return ListTile(
            title: Text(user['username']),
            onTap: () => onUserTap(user['_id']),
          );
        },
      ),
    );
  }
}
