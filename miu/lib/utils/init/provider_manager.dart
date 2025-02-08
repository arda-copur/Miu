import 'package:miu/services/auth/auth_service.dart';
import 'package:miu/services/base/config.dart';
import 'package:miu/services/image/image_service.dart';
import 'package:miu/services/status/status_service.dart';
import 'package:miu/utils/connectivity/connectivity_manager.dart';
import 'package:miu/utils/permission/permission_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderManager {
  static MultiProvider init({required Widget child}) {
    return MultiProvider(
      providers: [
        Provider<Config>(create: (_) => Config()),
        Provider<AuthService>(
            create: (context) => AuthService(context.read<Config>())),
        ChangeNotifierProvider(
            create: (context) => StatusService(context.read<AuthService>())),
        ChangeNotifierProvider(create: (_) => ImageService()),
        ChangeNotifierProvider(create: (_) => PermissionManager()),
        ChangeNotifierProvider(create: (_) => ConnectivityManager()),
      ],
      child: child,
    );
  }
}
