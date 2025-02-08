import 'package:miu/views/create_post_view.dart';
import 'package:flutter/material.dart';

class CreatePostButton extends StatelessWidget {
  final VoidCallback onPostCreated;

  const CreatePostButton({Key? key, required this.onPostCreated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreatePostView()),
        );
        if (result == true) {
          onPostCreated();
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
