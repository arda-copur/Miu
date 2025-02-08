// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final Map<String, dynamic>? userData;
  const ProfileAvatar({
    Key? key,
    this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: userData?['profileImageUrl'] != null
          ? NetworkImage(userData!['profileImageUrl'])
          : null,
      child: userData?['profileImageUrl'] == null
          ? Text(userData?['username']?[0].toString().toUpperCase() ?? 'U',
              style: Theme.of(context).textTheme.displayMedium)
          : null,
    );
  }
}
