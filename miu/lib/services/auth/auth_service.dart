import 'package:miu/services/base/base_response.dart';
import 'package:miu/services/base/base_service.dart';
import 'package:miu/services/base/config.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends BaseService {
  AuthService(Config config) : super(config);

  Future<BaseResponse<String>> registerUser(
      String username, String email, String password) async {
    var response = await post<Map<String, dynamic>>(
      '${config.authApi}/${config.registerEndpoint}',
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );

    if (response.data != null) {
      var token = response.data!['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      String? playerId = await OneSignal.User.getOnesignalId();
      if (playerId != null) {
        await updateUserOneSignalPlayerId(playerId);
      }

      return BaseResponse(data: token, message: "Kayıt başarılı!");
    } else {
      return BaseResponse(error: response.error, message: "Kayıt başarısız!");
    }
  }

  Future<BaseResponse<String>> loginUser(String email, String password) async {
    var response = await post<Map<String, dynamic>>(
      '${config.authApi}/${config.loginEndpoint}',
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.data != null) {
      var token = response.data!['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      String? playerId = await OneSignal.User.getOnesignalId();
      if (playerId != null) {
        await updateUserOneSignalPlayerId(playerId);
      }

      return BaseResponse(data: token, message: "Giriş başarılı!");
    } else {
      return BaseResponse(error: response.error, message: "Giriş başarısız!");
    }
  }

  Future<BaseResponse<void>> updateUserOneSignalPlayerId(
      String playerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var response = await put<Map<String, dynamic>>(
      '${config.authApi}/${config.oneSignalEndpoint}',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        'oneSignalPlayerId': playerId,
      },
    );

    if (response.error != null) {
      return BaseResponse(
          error: response.error, message: "OneSignal ID güncellenemedi!");
    }

    return BaseResponse(message: "OneSignal ID başarıyla güncellendi!");
  }

  Future<BaseResponse<void>> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    return BaseResponse(message: "Çıkış yapıldı!");
  }
}
