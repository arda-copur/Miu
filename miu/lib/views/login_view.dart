import 'package:miu/utils/extensions/image_extension.dart';
import 'package:miu/utils/routes/app_routes.dart';
import 'package:miu/utils/theme/app_theme.dart';
import 'package:miu/viewmodels/login_view_model.dart';
import 'package:miu/widgets/auth/custom_textfield.dart';
import 'package:miu/widgets/auth/password_textfield.dart';
import 'package:miu/widgets/auth/primary_button.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends LoginViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppTheme.extraPadding,
        child: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(PngImageItems.miuIconSecond.imagePath),
                CustomTextField(
                  hintText: hintEmail,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                PasswordTextField(
                  hintText: hintPassword,
                  controller: passwordController,
                ),
                PrimaryButton(
                  onTap: () => login(),
                  text: buttonTitle,
                ),
                GestureDetector(
                  onTap: () => AppRouter.navigateToRegister(context),
                  child: Text(
                    createAccount,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                if (isLoading) const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
