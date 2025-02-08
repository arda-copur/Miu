import 'dart:convert';
import 'package:miu/services/base/base_service.dart';
import 'package:miu/services/base/base_response.dart';
import 'package:miu/services/base/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService extends BaseService {
  ProfileService(Config config) : super(config);

  Future<BaseResponse<Map<String, dynamic>?>> getUserProfile(
      String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await get(
      '${config.profileApi}/$userId',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      var data = jsonDecode(response.data);
      return BaseResponse<Map<String, dynamic>?>(data: {
        ...data,
        'profileImageUrl': data['profileImageUrl'],
      }, message: "Kullanıcı profili başarıyla alındı.");
    } else {
      return BaseResponse<Map<String, dynamic>?>(
          error: response.error, message: "Kullanıcı profili alınamadı.");
    }
  }

  // Oturum açmış kullanıcının profilini çekme
  Future<BaseResponse<Map<String, dynamic>?>> getMyProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    if (token == null) {
      return BaseResponse<Map<String, dynamic>?>(
          error: "Token bulunamadı!", message: "Token bulunamadı!");
    }

    var response = await get(
      '${config.authApi}/${config.meEndpoint}',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      var data = jsonDecode(response.data);
      return BaseResponse<Map<String, dynamic>?>(data: {
        ...data,
        'profileImageUrl': data['profileImageUrl'], // URL'i olduğu gibi kullan
      }, message: "Profil başarıyla alındı.");
    } else {
      return BaseResponse<Map<String, dynamic>?>(
          error: response.error, message: "Profil alınamadı.");
    }
  }

  Future<BaseResponse<List<dynamic>>> getUserPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var response = await get(
      '${config.postsApi}/${config.userPostsEndpoint}',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      List<dynamic> posts = jsonDecode(response.data);
      return BaseResponse<List<dynamic>>(
          data: posts, message: "Kullanıcı gönderileri başarıyla alındı.");
    } else {
      return BaseResponse<List<dynamic>>(
          error: response.error, message: "Kullanıcı gönderileri alınamadı.");
    }
  }

  Future<BaseResponse<List<dynamic>>> getFeedPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var response = await get(
      '${config.postsApi}/${config.feedEndpoint}',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      List<dynamic> posts = jsonDecode(response.data);
      return BaseResponse<List<dynamic>>(
          data: posts,
          message: "Kullanıcı ve arkadaşlarının gönderileri başarıyla alındı.");
    } else {
      return BaseResponse<List<dynamic>>(
          error: response.error, message: "Gönderiler alınamadı.");
    }
  }
}
