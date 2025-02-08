import 'package:miu/utils/theme/app_theme.dart';
import 'package:miu/viewmodels/create_post_view_model.dart';
import 'package:flutter/material.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends CreatePostViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(createText),
        actions: [
          if (!isLoading)
            TextButton(
              onPressed: createPost,
              child: Text(shareText,
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
        ],
      ),
      body: Padding(
        padding: AppTheme.extraPadding,
        child: Column(
          children: [
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  errorMessage!,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppTheme.warningColor,
                      ),
                ),
              ),
            TextField(
              controller: postController,
              maxLines: postControllerMaxLines,
              maxLength: postControllerMaxLength,
              decoration: InputDecoration(
                hintText: whatDoYouThinkText,
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.customBlue, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
