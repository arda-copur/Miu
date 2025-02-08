import 'dart:convert';
import 'package:miu/services/base/base_service.dart';
import 'package:miu/services/base/base_response.dart';
import 'package:miu/services/base/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendService extends BaseService {
  FriendService(Config config) : super(config);

  Future<BaseResponse<bool>> sendFriendRequest(String friendId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await post(
      '${config.friendApi}/${config.friendsEndpoint}/$friendId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      return BaseResponse<bool>(
          data: true, message: "Arkadaşlık isteği gönderildi.");
    } else {
      return BaseResponse<bool>(
          error: response.error, message: "Arkadaşlık isteği gönderilemedi.");
    }
  }

  Future<BaseResponse<bool>> acceptFriendRequest(String friendId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await post(
      '${config.friendApi}/${config.acceptEndpoint}/$friendId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      return BaseResponse<bool>(
          data: true, message: "Arkadaşlık isteği kabul edildi.");
    } else {
      return BaseResponse<bool>(
          error: response.error, message: "Arkadaşlık isteği kabul edilemedi.");
    }
  }

  Future<BaseResponse<bool>> rejectFriendRequest(String friendId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await post(
      '${config.friendApi}/${config.rejectEndpoint}/$friendId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      return BaseResponse<bool>(
          data: true, message: "Arkadaşlık isteği reddedildi.");
    } else {
      return BaseResponse<bool>(
          error: response.error, message: "Arkadaşlık isteği reddedilemedi.");
    }
  }

  Future<BaseResponse<List<dynamic>>> getFriendRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await get(
      '${config.friendApi}/${config.requestsEndpoint}',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      List<dynamic> requests = json.decode(response.data);
      return BaseResponse<List<dynamic>>(
          data: requests, message: "Arkadaşlık istekleri başarıyla alındı.");
    } else {
      return BaseResponse<List<dynamic>>(
          error: response.error, message: "Arkadaşlık istekleri alınamadı.");
    }
  }

  Future<BaseResponse<bool>> checkFriendStatus(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await get(
      '${config.friendApi}/${config.statusEndpoint}/$userId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      var jsonData = json.decode(response.data);
      return BaseResponse<bool>(
          data: jsonData['isFriend'], message: "Arkadaşlık durumu alındı.");
    } else {
      return BaseResponse<bool>(
          error: response.error, message: "Arkadaşlık durumu alınamadı.");
    }
  }

  Future<BaseResponse<List<dynamic>>> getFriendsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await get(
      '${config.friendApi}/${config.friendsEndpoint}',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      var friends = json.decode(response.data);
      return BaseResponse<List<dynamic>>(
          data: friends, message: "Arkadaşlar başarıyla alındı.");
    } else {
      return BaseResponse<List<dynamic>>(
          error: response.error, message: "Arkadaşlar alınamadı.");
    }
  }

  Future<BaseResponse<List<dynamic>>> getUserFriends(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await get(
      '${config.friendApi}/${config.listEndpoint}/$userId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.isSuccess) {
      var data = json.decode(response.data);
      return BaseResponse<List<dynamic>>(
          data: data, message: "Kullanıcı arkadaşları başarıyla alındı.");
    } else {
      return BaseResponse<List<dynamic>>(
          error: response.error, message: "Kullanıcı arkadaşları alınamadı.");
    }
  }
}
