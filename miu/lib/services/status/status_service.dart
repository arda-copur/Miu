import 'package:miu/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class StatusService with ChangeNotifier {
  final AuthService _authService;

  StatusService(this._authService);

  String? token;
  bool get isAuthenticated => token != null;

  Future<void> login(String email, String password) async {
    var response = await _authService.loginUser(email, password);
    if (response.error == null) {
      token = response.data;
    }
    notifyListeners();
  }

  Future<void> register(String username, String email, String password) async {
    var response = await _authService.registerUser(username, email, password);
    if (response.error == null) {
      token = response.data;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    var response = await _authService.logoutUser();
    if (response.error == null) {
      token = null;
    }
    notifyListeners();
  }
}
