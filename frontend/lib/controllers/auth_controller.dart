import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final result = await _authService.login(email, password);

      if (result["success"] == true) {
        final prefs = await SharedPreferences.getInstance();
        final token = result["data"]["token"];

        await prefs.setString("token", token);
        print("TOKEN = $token");
        await prefs.setInt(
          "userId",
          result["data"]["id"],
        );
        print(result);

        return {
          "success": true,
          "message": "Đăng nhập thành công"
        };
      }

      return {
        "success": false,
        "message": result["message"] ?? "Sai email hoặc mật khẩu"
      };

    } catch (e) {
      print(e);
      return {
        "success": false,
        "message": "Đã xảy ra lỗi hệ thống."
      };
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      final result = await _authService.register(username, email, password);
      return result["success"] == true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}