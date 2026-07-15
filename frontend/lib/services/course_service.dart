import 'dart:convert';

import 'package:http/http.dart'
as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/api_constant.dart';
import '../models/course_model.dart';

class CourseService {

  Future<List<CourseModel>>
  getCourses() async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response =
    await http.get(

      Uri.parse(
        ApiConstants.courses,
      ),

      headers: {
        "Authorization":
        "Bearer $token",
      },
    );

    print(
      "GET COURSES STATUS = ${response.statusCode}",
    );

    print(
      "GET COURSES BODY = ${response.body}",
    );

    if (response.statusCode == 200) {

      final json =
      jsonDecode(response.body);

      final List data =
      json["data"];

      return data
          .map(
            (e) =>
            CourseModel.fromJson(e),
      )
          .toList();
    }

    throw Exception(
      "Failed to load courses",
    );
  }

  Future<bool> createCourse(
      CourseModel course) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    print("TOKEN = $token");

    final response =
    await http.post(

      Uri.parse(
        ApiConstants.courses,
      ),

      headers: {
        "Content-Type":
        "application/json",

        "Authorization":
        "Bearer $token",
      },

      body: jsonEncode(
        course.toJson(),
      ),
    );

    print(response.statusCode);
    print(response.body);

    return response.statusCode == 201 ||
        response.statusCode == 200;
  }

  Future<bool> joinClass(String classCode) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response = await http.post(

      Uri.parse(
        "${ApiConstants.courses}/join",
      ),

      headers: {

        "Content-Type": "application/json",

        "Authorization": "Bearer $token",

      },

      body: jsonEncode({

        "classCode": classCode,

      }),

    );

    print(response.statusCode);
    print(response.body);

    return response.statusCode == 200;

  }

  Future<bool> updateCourse(
      int courseId,
      String description,
      int maxMembers,
      ) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response =
    await http.put(

      Uri.parse(
        "${ApiConstants.courses}/$courseId",
      ),

      headers: {

        "Content-Type":"application/json",

        "Authorization":"Bearer $token",

      },

      body: jsonEncode({

        "description":description,

        "maxMembers":maxMembers,

      }),

    );

    print(response.statusCode);
    print(response.body);

    return response.statusCode==200;

  }

  Future<CourseModel> getCourseDetail(int id) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response = await http.get(

      Uri.parse(
        "${ApiConstants.courses}/$id/detail",
      ),

      headers: {

        "Authorization":
        "Bearer $token",

      },

    );

    if (response.statusCode == 200) {

      final json =
      jsonDecode(response.body);

      return CourseModel.fromJson(
        json["data"],
      );

    }

    throw Exception("Load class failed");
  }
}