import 'package:miu/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final bool isActive;
  final VoidCallback onPressed;
  const ActionButton({
    Key? key,
    required this.icon,
    required this.count,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.customBlue : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(count.toString()),
          ],
        ),
      ),
    );
  }
}
