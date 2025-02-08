import 'package:miu/views/create_post_view.dart';
import 'package:flutter/material.dart';
import 'package:miu/views/home_view.dart';
import 'package:miu/views/login_view.dart';
import 'package:miu/views/profile_view.dart';
import 'package:miu/views/register_view.dart';

class AppRouter {
  const AppRouter._();

  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String create = '/create';
  static const String userProfile = '/user-profile';

  static const String initialRoute = register;

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginView(),
    register: (context) => const RegisterView(),
    home: (context) => const HomeView(),
    profile: (context) => const ProfileView(),
    create: (context) => const CreatePostView(),
    userProfile: (context) => const ProfileView(),
  };

  static Future<void> navigateToLogin(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, login);
  }

  static Future<void> navigateToRegister(BuildContext context) async {
    await Navigator.pushNamed(context, register);
  }

  static Future<void> navigateToHome(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, home);
  }

  static Future<void> navigateToProfile(BuildContext context) async {
    await Navigator.pushNamed(context, profile);
  }

  static Future<void> navigateToCreatePost(BuildContext context) async {
    await Navigator.pushNamed(context, create);
  }

  static Future<void> navigateToUserProfile(BuildContext context) async {
    await Navigator.pushNamed(context, userProfile);
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return const LoginView();
      },
    );
  }

  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('${settings.name}  bulunamadı'),
        ),
      ),
    );
  }
}
