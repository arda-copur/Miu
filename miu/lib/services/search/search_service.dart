import 'package:miu/services/base/base_service.dart';
import 'package:miu/services/base/base_response.dart';
import 'package:miu/services/base/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchService extends BaseService {
  SearchService(Config config) : super(config);

  Future<BaseResponse<List<dynamic>>> searchUsers(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    if (token == null) {
      return BaseResponse<List<dynamic>>(
        error: 'Token bulunamadı',
        message: 'Kullanıcı doğrulaması yapılmadı',
      );
    }

    final endpoint = '${config.baseUrl}/search/$query';
    final headers = {'Authorization': 'Bearer $token'};

    try {
      var response = await get<List<dynamic>>(
        endpoint,
        headers: headers,
        fromJson: (json) => List<dynamic>.from(json),
      );

      if (response.error != null) {
        return BaseResponse<List<dynamic>>(
          error: response.error,
          message: response.message ?? 'Bir hata oluştu',
        );
      }

      return response;
    } catch (e) {
      return BaseResponse<List<dynamic>>(
        error: 'Beklenmedik bir hata oluştu',
        message: e.toString(),
      );
    }
  }
}
