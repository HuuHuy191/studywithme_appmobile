import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/utils/storage_helper.dart';

class ApiService {
  // Hàm chung để gửi các yêu cầu có kèm Token (GET, POST, PUT, DELETE)
  static Future<http.Response> getRequest(String url) async {
    String? token = await StorageHelper.getToken();
    return await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Tự động đính kèm Token
      },
    );
  }

  static Future<http.Response> postRequest(String url, Map<String, dynamic> body) async {
    String? token = await StorageHelper.getToken();
    return await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

// Tương tự cho putRequest và deleteRequest...
}