import 'package:miu/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const PasswordTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
  }) : super(key: key);

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre alanı boş olamaz.';
    } else if (value.length < 4) {
      return 'Şifre en az 4 karakter olmalı.';
    } else if (!RegExp(r'\d').hasMatch(value)) {
      return 'Şifre en az bir sayı içermelidir.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: AppTheme.hugeCircular,
            boxShadow: [
              BoxShadow(
                color: AppTheme.appBlack.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(
              color: AppTheme.white,
              width: 1.5,
            ),
          ),
          child: TextFormField(
            validator: _passwordValidator,
            controller: controller,
            style: const TextStyle(color: AppTheme.appBlack),
            keyboardType: keyboardType,
            obscureText: true,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[400]),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
