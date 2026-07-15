import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/api_constant.dart';
import '../models/quiz_model.dart';
import '../models/quiz_group_model.dart';
class QuizService {

  // Lấy danh sách Quiz của lớp
  Future<List<QuizModel>> getQuizzes(
      int courseId) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response = await http.get(

      Uri.parse(
        "${ApiConstants.quiz}/course/$courseId",
      ),

      headers: {

        "Authorization":
        "Bearer $token",

      },

    );

    if (response.statusCode == 200) {

      final json =
      jsonDecode(response.body);

      final List data =
      json["data"];

      return data
          .map(
            (e) =>
            QuizModel.fromJson(e),
      )
          .toList();

    }

    throw Exception("Load quiz failed");

  }

  // Tạo Quiz + Question
  Future<bool> createFullQuiz(
      QuizModel quiz) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response =
    await http.post(

      Uri.parse(
        "${ApiConstants.quiz}/full",
      ),

      headers: {

        "Content-Type":
        "application/json",

        "Authorization":
        "Bearer $token",

      },

      body:
      jsonEncode(
        quiz.toJson(),
      ),

    );

    return response.statusCode == 201;

  }

  // Sửa Quiz
  Future<bool> updateQuiz(
      QuizModel quiz) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response =
    await http.put(

      Uri.parse(
        "${ApiConstants.quiz}/${quiz.id}",
      ),

      headers: {

        "Content-Type":
        "application/json",

        "Authorization":
        "Bearer $token",

      },

      body:
      jsonEncode(
        quiz.toJson(),
      ),

    );

    return response.statusCode == 200;

  }

  // Xóa Quiz
  Future<bool> deleteQuiz(
      int quizId) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response =
    await http.delete(

      Uri.parse(
        "${ApiConstants.quiz}/$quizId",
      ),

      headers: {

        "Authorization":
        "Bearer $token",

      },

    );

    return response.statusCode == 200;

  }
  // Lấy tất cả Quiz của các lớp đã tham gia
  Future<List<QuizGroupModel>> getMyQuizzes() async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response = await http.get(

      Uri.parse(
        "${ApiConstants.quiz}/my",
      ),

      headers: {

        "Authorization":
        "Bearer $token",

      },

    );

    if (response.statusCode == 200) {

      final json =
      jsonDecode(response.body);

      final List data =
      json["data"];

      return data

          .map(
            (e) => QuizGroupModel.fromJson(e),
      )

          .toList();

    }

    throw Exception("Load My Quiz failed");

  }
  Future<QuizModel> getQuizDetail(
      int quizId,
      ) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response = await http.get(

      Uri.parse(
        "${ApiConstants.quiz}/$quizId",
      ),

      headers: {

        "Authorization":
        "Bearer $token",

      },

    );

    if (response.statusCode == 200) {

      return QuizModel.fromJson(

        jsonDecode(response.body)["data"],

      );

    }

    throw Exception("Load quiz failed");

  }

}