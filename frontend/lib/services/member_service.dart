import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/api_constant.dart';
import '../models/member_model.dart';

class MemberService {

  Future<List<MemberModel>> getMembers(
      int classId) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response = await http.get(

      Uri.parse(
          "${ApiConstants.baseUrl}/class-member/$classId"),

      headers: {

        "Authorization": "Bearer $token"

      },

    );

    if (response.statusCode == 200) {

      final json =
      jsonDecode(response.body);

      final List data =
      json["data"];

      return data
          .map((e) => MemberModel.fromJson(e))
          .toList();

    }

    throw Exception("Load members failed");
  }
  Future<bool> removeMember(
      int classId,
      int userId,
      ) async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    final response = await http.delete(

      Uri.parse(
        "${ApiConstants.baseUrl}/class-member/$classId/$userId",
      ),

      headers: {

        "Authorization": "Bearer $token",

      },

    );

    print(response.statusCode);
    print(response.body);

    return response.statusCode == 200;
  }
}