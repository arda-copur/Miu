import 'package:miu/services/base/config.dart';
import 'package:miu/services/friend/friend_service.dart';
import 'package:miu/services/image/image_service.dart';
import 'package:miu/services/profile/profile_service.dart';
import 'package:miu/views/profile_view.dart';
import 'package:flutter/material.dart';

abstract class ProfileViewModel extends State<ProfileView> {
  Map<String, dynamic>? userData;
  List<dynamic> userPosts = [];
  List<dynamic> friendRequests = [];
  List<dynamic> friendsList = [];
  bool isLoading = true;
  String? error;
  final ImageService imageService = ImageService();
  final String usernameText = 'Kullanıcı Adı';
  final String emailText = 'Email';
  final String friendRequestsText = 'Arkadaşlık İstekleri';
  final String userText = 'Kullanıcı';
  final String retweetsText = 'Paylaşım ve Retweetler';
  final String errorText = 'Bir hata oluştu';
  final String requestErrorText = 'İstek reddedilirken bir hata oluştu';
  final String requestDismissText = 'İstek reddedildi';
  final ProfileService profileService = ProfileService(Config());
  final FriendService friendService = FriendService(Config());

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      await Future.wait([
        fetchUserProfile(),
        fetchFriendRequests(),
        fetchFriendsList(),
      ]);
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      var userProfile = await profileService.getMyProfile();
      var userPosts = await profileService.getUserPosts();

      if (userProfile != null) {
        setState(() {
          userData = userProfile as Map<String, dynamic>?;
          userPosts = userPosts;
        });
      } else {
        throw Exception('Kullanıcı profili alınamadı!');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: ${e.toString()}')),
      );
    }
  }

  Future<void> fetchFriendRequests() async {
    try {
      var friendRequests = await friendService.getFriendRequests();
      setState(() {
        friendRequests = friendRequests;
      });
    } catch (e) {
      print('Arkadaşlık istekleri alınırken hata: $e');
    }
  }

  Future<void> fetchFriendsList() async {
    try {
      var friends = await friendService.getFriendsList();
      setState(() {
        friendsList = friends as List;
      });
    } catch (e) {
      print('Arkadaş listesi alınırken hata: $e');
    }
  }
}
