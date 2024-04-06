import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class PromptRepo {
  static String styleId = '32';
  static Future<Uint8List?> generateImage(String prompt) async {
    const String url = 'https://api.vyro.ai/v1/imagine/api/generations';
    const Map<String, dynamic> headers = {
      'Authorization': 'Bearer vk-XFHwIMfJyvxtn3g6t3CIDPS1LRty9hEv5MDFOo7FjfP6C'
    };
    final Map<String, dynamic> payload = {
      'prompt': prompt,
      'style_id': styleId,
      'aspect_ratio': '1:1',
      'cfg': '5',
      'seed': '4',
      'high_res_results': '1',
    };
    final FormData formData = FormData.fromMap(payload);
    Dio dio = Dio();
    dio.options = BaseOptions(
      headers: headers,
    );
    try {
      final response = await dio.post(
        url,
        data: formData,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        Uint8List uint8list = Uint8List.fromList(response.data);
        return uint8list;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<bool> saveToGallery(Uint8List imageBytes) async {
    try {
      // Save the image to the gallery
      await ImageGallerySaver.saveImage(imageBytes);
      return true;
    } catch (e) {
      log('Error saving image to gallery: $e');
      return false;
    }
  }
}
