import 'package:miu/services/search/search_service.dart';
import 'package:miu/services/base/config.dart';
import 'package:miu/services/image/image_service.dart';
import 'package:miu/services/post/post_service.dart';
import 'package:miu/services/profile/profile_service.dart';
import 'package:miu/utils/theme/app_theme.dart';
import 'package:miu/views/home_view.dart';
import 'package:flutter/material.dart';

abstract class HomeViewModel extends State<HomeView> {
  List<dynamic> posts = [];
  List<dynamic> searchedUsers = [];
  String searchQuery = '';
  final ImageService imageService = ImageService();
  final SearchService searchService = SearchService(Config());
  final ProfileService profileService = ProfileService(Config());
  final String usersText = 'Kullanıcılar:';
  final String cancelText = 'İptal';
  final String shareText = "Paylaş";
  final String commentLabelText = "Yorum";
  final String addCommentText = "Yorum Ekle";
  final String errorText = "Gönderiler yüklenirken bir hata oluştu";

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      var posts = await profileService.getFeedPosts();
      setState(() {
        posts = posts;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorText),
          backgroundColor: AppTheme.warningColor,
        ),
      );
    }
  }

  Future<void> searchUsers(String query) async {
    var users = await searchService.searchUsers(query);
    setState(() {
      searchedUsers = users as List;
    });
  }

  void showCommentDialog(String postId) {
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(addCommentText),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(labelText: commentLabelText),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(cancelText),
            ),
            ElevatedButton(
              onPressed: () {
                PostService(Config())
                    .commentOnPost(postId, commentController.text);
                Navigator.pop(context);
                fetchPosts();
              },
              child: Text(shareText),
            ),
          ],
        );
      },
    );
  }
}
