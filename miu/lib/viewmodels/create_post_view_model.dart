import 'package:miu/services/base/config.dart';
import 'package:miu/services/post/post_service.dart';
import 'package:miu/views/create_post_view.dart';
import 'package:flutter/material.dart';

abstract class CreatePostViewModel extends State<CreatePostView> {
  final TextEditingController postController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;
  final String whatDoYouThinkText = 'Ne düşünüyorsun?';
  final String createText = 'Gönderi Oluştur';
  final String shareText = 'Paylaş';
  final int postControllerMaxLines = 5;
  final int postControllerMaxLength = 280;

  Future<void> createPost() async {
    if (postController.text.trim().isEmpty) {
      setState(() {
        errorMessage = 'Lütfen içerik girin';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      bool success = (await PostService(Config())
          .createPost(postController.text.trim())) as bool;

      if (success) {
        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        setState(() {
          errorMessage = 'Gönderi paylaşılamadı';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Bir hata oluştu: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }
}
