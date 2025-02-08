import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  // Medya ve boyutlar
  ThemeData get theme => Theme.of(context);
  MediaQueryData get mediaQuery => MediaQuery.of(context);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;

  void showSnackbar(String message,
      {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: duration),
    );
  }

  Future<void> showAlert({
    required String title,
    required String content,
    String confirmText = "Tamam",
    VoidCallback? onConfirm,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onConfirm ?? () => Navigator.pop(context),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }

  void navigateTo(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  void navigateAndReplace(Widget page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  void navigateBack() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void setPortraitMode() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void setLandscapeMode() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  void refreshUI() {
    if (mounted) {
      setState(() {});
    }
  }
}
