import 'dart:convert';
import 'package:miu/services/base/base_service.dart';
import 'package:miu/services/base/base_response.dart';
import 'package:miu/services/base/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostService extends BaseService {
  PostService(Config config) : super(config);

  Future<BaseResponse<bool>> createPost(String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await post(
      config.postsApi,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        'content': content,
      },
    );

    if (response.isSuccess) {
      return BaseResponse(
          data: true, message: "Gönderi başarıyla oluşturuldu.");
    } else {
      return BaseResponse(
          error: response.error, message: "Gönderi oluşturulamadı.");
    }
  }

  Future<BaseResponse<bool>> likePost(String postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await put(
      '${config.postsApi}/${config.likeEndpoint}/$postId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      return BaseResponse(data: true, message: "Gönderi başarıyla beğenildi.");
    } else {
      return BaseResponse(
          error: response.error, message: "Gönderi beğenilemedi.");
    }
  }

  Future<BaseResponse<bool>> commentOnPost(
      String postId, String comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await post(
      '${config.postsApi}/${config.commentEndpoint}/$postId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        'comment': comment,
      },
    );

    if (response.isSuccess) {
      return BaseResponse(data: true, message: "Yorum başarıyla eklendi.");
    } else {
      return BaseResponse(error: response.error, message: "Yorum eklenemedi.");
    }
  }

  Future<BaseResponse<bool>> retweetPost(String postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await put(
      '${config.postsApi}/${config.retweetEndpoint}/$postId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      return BaseResponse(
          data: true, message: "Gönderi başarıyla retweetlendi.");
    } else {
      return BaseResponse(
          error: response.error, message: "Gönderi retweetlenemedi.");
    }
  }

  Future<BaseResponse<List<dynamic>>> getPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await get(
      config.postsApi,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      List<dynamic> posts = jsonDecode(response.data);
      return BaseResponse<List<dynamic>>(
          data: posts, message: "Gönderiler başarıyla alındı.");
    } else {
      return BaseResponse<List<dynamic>>(
          error: response.error, message: "Gönderiler alınamadı.");
    }
  }

  Future<BaseResponse<List<dynamic>>> getOtherUserPosts(
      {required String userId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await get(
      '${config.postsApi}/${config.userEndpoint}/$userId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      var data = json.decode(response.data);
      return BaseResponse<List<dynamic>>(
          data: data, message: "Kullanıcı gönderileri başarıyla alındı.");
    } else {
      return BaseResponse<List<dynamic>>(
          error: response.error, message: "Kullanıcı gönderileri alınamadı.");
    }
  }
}
