import 'package:miu/utils/init/app_init.dart';
import 'package:miu/utils/init/provider_manager.dart';
import 'package:miu/utils/routes/app_routes.dart';
import 'package:miu/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInit().initializeApp();
  runApp(ProviderManager.init(child: const Miu()));
}

class Miu extends StatelessWidget {
  const Miu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppInit.title,
      debugShowCheckedModeBanner: AppInit.debugShowCheckModeBanner,
      theme: AppTheme.appTheme,
      initialRoute: AppRouter.initialRoute,
      routes: AppRouter.routes,
      onGenerateRoute: AppRouter.onGenerateRoute,
      onUnknownRoute: AppRouter.onUnknownRoute,
    );
  }
}
