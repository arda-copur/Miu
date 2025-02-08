import 'package:miu/services/status/status_service.dart';
import 'package:miu/utils/theme/app_theme.dart';
import 'package:miu/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class LoginViewModel extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final hintEmail = 'Email';
  final hintPassword = "Şifre";
  final createAccount = "Henüz hesabınız yok mu? Hesap oluşturun";
  bool isLoading = false;
  final String buttonTitle = "Giriş";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      await context.read<StatusService>().login(
            emailController.text.trim(),
            passwordController.text,
          );

      if (mounted) {
        if (context.read<StatusService>().isAuthenticated) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          showErrorMessage('Giriş başarısız');
        }
      }
    } catch (e) {
      showErrorMessage('Bir hata oluştu: ${e.toString()}');
    }
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppTheme.warningColor),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email boş bırakılamaz.';
    } else if (!RegExp(r'^[a-zA-Z0-9_.+-]+@(gmail\.com|hotmail\.com)$')
        .hasMatch(value)) {
      return 'Geçerli bir email adresi giriniz.';
    }
    return null;
  }
}
