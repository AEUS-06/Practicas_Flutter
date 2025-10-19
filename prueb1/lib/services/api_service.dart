import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // Cambia esta IP a la de tu PC (la misma que usas para correr uvicorn)
  static const String baseUrl = "http://192.168.0.17:8000";

  /// Subir una sola imagen
  static Future<Map<String, dynamic>> subirImagen(File image) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/subir_imagen'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        var respStr = await response.stream.bytesToString();
        return jsonDecode(respStr);
      } else {
        return {'success': false, 'error': 'Error HTTP: ${response.statusCode}'};
      }
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Comparar dos imágenes
  static Future<Map<String, dynamic>> compararImagenes(File img1, File img2) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/comparar'),
      );
      request.files.add(await http.MultipartFile.fromPath('img1', img1.path));
      request.files.add(await http.MultipartFile.fromPath('img2', img2.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        var respStr = await response.stream.bytesToString();
        return jsonDecode(respStr);
      } else {
        return {'success': false, 'error': 'Error HTTP: ${response.statusCode}'};
      }
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }
}
