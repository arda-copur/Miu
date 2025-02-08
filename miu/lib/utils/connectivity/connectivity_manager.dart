import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityManager extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  bool _isConnected = false;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  ConnectivityProvider() {
    _initConnectivity();
  }

  ConnectivityResult get connectionStatus => _connectionStatus;

  bool get isConnected => _isConnected;

  Future<void> _initConnectivity() async {
    _connectionStatus =
        (await _connectivity.checkConnectivity()) as ConnectivityResult;
    _updateConnectionStatus(_connectionStatus);
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
            _updateConnectionStatus as void Function(
                List<ConnectivityResult> event)?)
        as StreamSubscription<ConnectivityResult>?;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus = result;
    _isConnected = result != ConnectivityResult.none;
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
