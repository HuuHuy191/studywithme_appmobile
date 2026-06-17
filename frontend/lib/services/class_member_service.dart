import 'dart:convert';

import 'package:http/http.dart'
as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/api_constant.dart';

class ClassMemberService {

  Future<bool> joinClass(
      String classCode) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response =
    await http.post(

      Uri.parse(
        ApiConstants.joinClass,
      ),

      headers: {

        "Content-Type":
        "application/json",

        "Authorization":
        "Bearer $token",
      },

      body: jsonEncode({

        "classCode":
        classCode,

      }),
    );

    return response.statusCode == 200;
  }
}