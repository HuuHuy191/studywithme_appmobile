import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/constants/api_constant.dart';
import '../models/course_model.dart';

class CourseService {

  Future<List<CourseModel>> getCourses() async {

    final response = await http.get(
      Uri.parse(ApiConstants.courses),
    );

    final data = jsonDecode(response.body);

    return data
        .map<CourseModel>(
          (e) => CourseModel.fromJson(e),
    )
        .toList();
  }

  Future<bool> createCourse(
      CourseModel course) async {

    final response = await http.post(
      Uri.parse(ApiConstants.courses),
      headers: {
        "Content-Type":
        "application/json"
      },
      body: jsonEncode(
        course.toJson(),
      ),
    );

    return response.statusCode == 201;
  }
}