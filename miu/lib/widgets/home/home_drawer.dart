import 'package:miu/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onLogoutTap;

  const HomeDrawer({
    Key? key,
    required this.onProfileTap,
    required this.onLogoutTap,
  }) : super(key: key);

  final String userMenuTitle = 'Kullanıcı Menüsü';
  final String profileTitle = 'Profil';
  final String exitTitle = 'Çıkış';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.appNeutral),
            child: Text(
              userMenuTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            title: const Text(profileTitle),
            onTap: onProfileTap,
          ),
          ListTile(
            title: const Text(exitTitle),
            onTap: onLogoutTap,
          ),
        ],
      ),
    );
  }
}
