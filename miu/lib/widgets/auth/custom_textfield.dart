import 'package:miu/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppTheme.hugeCircular,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
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
            validator: validator,
            controller: controller,
            style: const TextStyle(color: AppTheme.appBlack),
            keyboardType: keyboardType,
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
