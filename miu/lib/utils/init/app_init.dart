import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AppInit {
  static final AppInit _instance = AppInit._internal();

  static String title = "Miu";
  static bool debugShowCheckModeBanner = false;

  factory AppInit() {
    return _instance;
  }

  AppInit._internal();

  Future<void> initializeApp() async {
    await dotenv.load(fileName: '.env');
    await _initializeOneSignal();
  }

  Future<void> _initializeOneSignal() async {
    OneSignal.initialize(dotenv.env['ONESIGNAL_API_KEY'] ?? 'Not Available');
    await OneSignal.Notifications.requestPermission(true).then((accepted) {});
    OneSignal.User.pushSubscription.addObserver((state) {});
  }
}
