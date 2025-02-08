import 'package:miu/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final String searchQuery;
  final Function(String) onSearchQueryChanged;

  const CustomSearchBar({
    Key? key,
    required this.searchQuery,
    required this.onSearchQueryChanged,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);
  final String userSearchHintText = 'Kullanıcı ara...';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.smallPadding,
      child: TextField(
        onChanged: onSearchQueryChanged,
        decoration: InputDecoration(
            hintText: userSearchHintText,
            border: OutlineInputBorder(
              borderRadius: AppTheme.primaryCircular,
              borderSide: const BorderSide(color: AppTheme.white),
            ),
            filled: true,
            fillColor: AppTheme.white),
      ),
    );
  }
}
