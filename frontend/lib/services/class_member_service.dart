import 'dart:convert';

import 'package:http/http.dart'
as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/api_constant.dart';

import '../models/course_model.dart';

class ClassMemberService {

  Future<bool> joinClass(
      String classCode) async {
    print("JOIN API");
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

    print("STATUS = ${response.statusCode}");
    print("BODY = ${response.body}");

    return response.statusCode == 200;
  }

  Future<List<CourseModel>> getJoinedClasses() async {
    print("========== GET JOINED CLASSES ==========");

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response = await http.get(

      Uri.parse(
        "${ApiConstants.baseUrl}/class-member/my-classes",
      ),

      headers: {

        "Authorization":
        "Bearer $token",

      },

    );

    print(
        "GET JOINED STATUS = ${response.statusCode}");

    print(
        "GET JOINED BODY = ${response.body}");

    if (response.statusCode == 200) {

      final json =
      jsonDecode(response.body);

      final List data =
      json["data"];

      return data.map<CourseModel>((e) {

        return CourseModel.fromJson(
          e["Classroom"],
        );

      }).toList();

    }

    throw Exception(
        "Không tải được danh sách lớp");
  }
}