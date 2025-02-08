import 'package:miu/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CameraIcon extends StatelessWidget {
  const CameraIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        padding: AppTheme.minPadding,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.camera_alt,
          color: AppTheme.white,
          size: 20,
        ),
      ),
    );
  }
}
