import 'package:miu/services/status/status_service.dart';
import 'package:miu/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class RegisterViewModel extends State<RegisterView> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final hintUsername = "Kullanıcı adı";
  final hintEmail = "Email";
  final hintPassword = "Şifre";
  final buttonTitle = "Kayıt Ol";
  final registerKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kullanıcı adı boş olamaz.';
    } else if (value.length < 4) {
      return 'Kullanıcı adı en az 4 karakter olmalı.';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email alanı boş olamaz.';
    } else if (!RegExp(r'^[a-zA-Z0-9_.+-]+@(gmail\.com|hotmail\.com)$')
        .hasMatch(value)) {
      return 'Mail adresi geçersiz.';
    }
    return null;
  }

  void register() {
    if (registerKey.currentState?.validate() ?? false) {
      context
          .read<StatusService>()
          .register(
            usernameController.text,
            emailController.text,
            passwordController.text,
          )
          .then((_) {
        if (context.read<StatusService>().isAuthenticated) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    }
  }
}
