import 'package:miu/services/base/config.dart';
import 'package:miu/services/friend/friend_service.dart';
import 'package:miu/services/image/image_service.dart';
import 'package:miu/services/post/post_service.dart';
import 'package:miu/services/profile/profile_service.dart';
import 'package:miu/views/user_profile.dart';
import 'package:flutter/material.dart';

abstract class UserProfileViewModel extends State<UserProfileView> {
  Map<String, dynamic>? userProfile;
  List<dynamic> userPosts = [];
  List<dynamic> friendsList = [];
  bool isFriend = false;
  bool isLoading = true;
  final ImageService imageService = ImageService();
  final String userNotFoundText = 'Kullanıcı bulunamadı';
  final String userName = 'username';
  final String email = 'email';
  ProfileService profileService = ProfileService(Config());
  FriendService friendService = FriendService(Config());
  PostService postService = PostService(Config());

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final results = await Future.wait([
        profileService.getUserProfile(widget.userId),
        friendService.checkFriendStatus(widget.userId),
        postService.getOtherUserPosts(userId: widget.userId),
        friendService.getUserFriends(widget.userId),
      ]);

      setState(() {
        userProfile = results[0] as Map<String, dynamic>?;
        isFriend = results[1] as bool;
        userPosts = results[2] as List<dynamic>;
        friendsList = results[3] as List<dynamic>;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veri yükleme hatası: $e'),
        ),
      );
    }
  }
}
