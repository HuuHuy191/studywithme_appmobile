import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/constants/api_constant.dart';

class AuthService {
  Future<Map<String, dynamic>> login(
      String email,
      String password) async {

    final response = await http.post(
      Uri.parse(ApiConstants.login),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    print("LOGIN STATUS = ${response.statusCode}");
    print("LOGIN BODY = ${response.body}");

    return jsonDecode(response.body);
  }
  Future<Map<String, dynamic>> register(
      String username,
      String email,
      String password,
      ) async {

    print("CALL API: ${ApiConstants.register}");

    final response = await http.post(
      Uri.parse(ApiConstants.register),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("BODY: ${response.body}");

    return jsonDecode(response.body);
  }
}