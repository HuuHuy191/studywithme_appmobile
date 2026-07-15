import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/api_constant.dart';
import '../models/vocab_model.dart';

class VocabService {

  // =========================
  // Lấy danh sách Vocabulary
  // =========================
  Future<List<VocabModel>> getVocabs(int courseId) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.get(

      Uri.parse(
        "${ApiConstants.vocab}/course/$courseId",
      ),

      headers: {
        "Authorization": "Bearer $token",
      },

    );

    print("GET VOCAB STATUS = ${response.statusCode}");
    print("GET VOCAB BODY = ${response.body}");

    if (response.statusCode == 200) {

      final json = jsonDecode(response.body);

      final List data = json["data"];

      return data
          .map((e) => VocabModel.fromJson(e))
          .toList();

    }

    throw Exception("Load vocab failed");

  }

  // =========================
  // Thêm Vocabulary
  // =========================
  Future<bool> createVocab(VocabModel vocab) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.post(

      Uri.parse(ApiConstants.vocab),

      headers: {

        "Content-Type": "application/json",

        "Authorization": "Bearer $token",

      },

      body: jsonEncode(
        vocab.toJson(),
      ),

    );

    print("CREATE STATUS = ${response.statusCode}");
    print("CREATE BODY = ${response.body}");

    return response.statusCode == 201;

  }

  // =========================
  // Cập nhật Vocabulary
  // =========================
  Future<bool> updateVocab(VocabModel vocab) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.put(

      Uri.parse(
        "${ApiConstants.vocab}/${vocab.id}",
      ),

      headers: {

        "Content-Type": "application/json",

        "Authorization": "Bearer $token",

      },

      body: jsonEncode(
        vocab.toJson(),
      ),

    );

    print("UPDATE STATUS = ${response.statusCode}");
    print("UPDATE BODY = ${response.body}");

    return response.statusCode == 200;

  }

  // =========================
  // Xóa Vocabulary
  // =========================
  Future<bool> deleteVocab(int vocabId) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.delete(

      Uri.parse(
        "${ApiConstants.vocab}/$vocabId",
      ),

      headers: {

        "Authorization": "Bearer $token",

      },

    );

    print("DELETE STATUS = ${response.statusCode}");
    print("DELETE BODY = ${response.body}");

    return response.statusCode == 200;

  }

}