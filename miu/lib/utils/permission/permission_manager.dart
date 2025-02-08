import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager extends ChangeNotifier {
  Map<Permission, PermissionStatus> _permissionsStatus = {};

  Map<Permission, PermissionStatus> get permissionsStatus => _permissionsStatus;

  Future<void> checkPermissions(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> status = {};
    for (var permission in permissions) {
      status[permission] = await permission.status;
    }
    _permissionsStatus = status;
    notifyListeners();
  }

  Future<bool> requestPermission(Permission permission) async {
    final result = await permission.request();
    _permissionsStatus[permission] = result;
    notifyListeners();
    return result.isGranted;
  }

  Future<void> requestMultiplePermissions(List<Permission> permissions) async {
    final results = await permissions.request();
    _permissionsStatus.addAll(results);
    notifyListeners();
  }

  bool isPermissionGranted(Permission permission) {
    return _permissionsStatus[permission] == PermissionStatus.granted;
  }

  bool shouldShowRationale(Permission permission) {
    return _permissionsStatus[permission] == PermissionStatus.permanentlyDenied;
  }

  Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
