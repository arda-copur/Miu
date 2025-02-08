import 'dart:io';
import 'package:miu/services/base/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageService extends ChangeNotifier {
  File? _imageFile;
  Config config = Config();
  final ImagePicker _picker = ImagePicker();

  Future<String?> uploadProfilePhoto(File photo) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token bulunamadı!');
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${config.baseUrl}/${config.profileApi}/${config.uploadPhotoEndpoint}'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          photo.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseData);

      if (response.statusCode == 200) {
        notifyListeners();
        return jsonResponse['imageUrl'];
      } else {
        throw Exception(jsonResponse['error'] ?? 'Fotoğraf yüklenemedi');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> showImageSourceDialog(BuildContext context) async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Fotoğraf Kaynağı'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeri'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      await pickAndUploadImage(context, source);
    }
  }

  Future<void> pickAndUploadImage(
      BuildContext context, ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fotoğraf yükleniyor...')),
        );

        final imageUrl = await uploadProfilePhoto(_imageFile!);

        if (imageUrl != null) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profil fotoğrafı güncellendi')),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: ${e.toString()}')),
        );
      }
    }
  }

  String getFullImageUrl(String? partialUrl) {
    if (partialUrl == null || partialUrl.isEmpty) return '';
    if (partialUrl.startsWith('http')) return partialUrl;
    return '${config.baseImageUrl}$partialUrl';
  }

  File? get imageFile => _imageFile;
}
