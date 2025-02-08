import 'package:miu/services/image/image_service.dart';
import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  final Map<String, dynamic> userProfile;
  final ImageService imageService;

  const ProfilePhoto({
    Key? key,
    required this.userProfile,
    required this.imageService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: userProfile['profileImageUrl'] != null
            ? NetworkImage(
                imageService.getFullImageUrl(userProfile['profileImageUrl']))
            : null,
        child: userProfile['profileImageUrl'] == null
            ? Text(userProfile['username'][0].toUpperCase())
            : null,
      ),
    );
  }
}
