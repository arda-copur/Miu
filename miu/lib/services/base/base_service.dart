import 'dart:convert';
import 'package:miu/services/base/base_response.dart';
import 'package:miu/services/base/config.dart';
import 'package:http/http.dart' as http;

class BaseService {
  final Config config;

  BaseService(this.config);

  Future<BaseResponse<T>> get<T>(String endpoint,
      {Map<String, String>? headers,
      T Function(dynamic json)? fromJson}) async {
    final uri = Uri.parse('${config.baseUrl}/$endpoint');
    try {
      final response = await http.get(uri, headers: headers);
      return _handleResponse(response, fromJson);
    } catch (e) {
      return BaseResponse<T>(error: 'Network error: $e');
    }
  }

  Future<BaseResponse<T>> post<T>(String endpoint,
      {Map<String, String>? headers,
      dynamic body,
      T Function(dynamic json)? fromJson}) async {
    final uri = Uri.parse('${config.baseUrl}/$endpoint');
    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(body));
      return _handleResponse(response, fromJson);
    } catch (e) {
      return BaseResponse<T>(error: 'Network error: $e');
    }
  }

  Future<BaseResponse<T>> put<T>(String endpoint,
      {Map<String, String>? headers,
      dynamic body,
      T Function(dynamic json)? fromJson}) async {
    final uri = Uri.parse('${config.baseUrl}/$endpoint');
    try {
      final response =
          await http.put(uri, headers: headers, body: jsonEncode(body));
      return _handleResponse(response, fromJson);
    } catch (e) {
      return BaseResponse<T>(error: 'Network error: $e');
    }
  }

  Future<BaseResponse<T>> delete<T>(String endpoint,
      {Map<String, String>? headers,
      T Function(dynamic json)? fromJson}) async {
    final uri = Uri.parse('${config.baseUrl}/$endpoint');
    try {
      final response = await http.delete(uri, headers: headers);
      return _handleResponse(response, fromJson);
    } catch (e) {
      return BaseResponse<T>(error: 'Network error: $e');
    }
  }

  BaseResponse<T> _handleResponse<T>(
      http.Response response, T Function(dynamic json)? fromJson) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (fromJson != null) {
        return BaseResponse<T>(data: fromJson(jsonDecode(response.body)));
      }
      return BaseResponse<T>(data: jsonDecode(response.body) as T);
    } else {
      return BaseResponse<T>(
          error: 'Error ${response.statusCode}: ${response.body}');
    }
  }
}
