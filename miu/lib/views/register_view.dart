import 'package:miu/utils/extensions/image_extension.dart';
import 'package:miu/utils/theme/app_theme.dart';
import 'package:miu/viewmodels/register_view_model.dart';
import 'package:miu/widgets/auth/custom_textfield.dart';
import 'package:miu/widgets/auth/password_textfield.dart';
import 'package:miu/widgets/auth/primary_button.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends RegisterViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppTheme.smallPadding,
        child: SingleChildScrollView(
          child: Form(
            key: registerKey,
            child: Column(
              children: [
                Image.asset(PngImageItems.miu.imagePath),
                CustomTextField(
                  hintText: hintUsername,
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  validator: validateUsername,
                ),
                CustomTextField(
                  hintText: hintEmail,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                PasswordTextField(
                    hintText: hintPassword, controller: passwordController),
                PrimaryButton(
                  onTap: register,
                  text: buttonTitle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
