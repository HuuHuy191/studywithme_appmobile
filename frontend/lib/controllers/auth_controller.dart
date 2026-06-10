import '../services/auth_service.dart';

class AuthController {
  final AuthService _authService =
  AuthService();

  Future<bool> login(
      String email,
      String password) async {

    try {
      final result =
      await _authService.login(
        email,
        password,
      );

      return result["success"] == true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> register(
      String username,
      String email,
      String password,
      ) async {
    try {
      final result = await _authService.register(
        username,
        email,
        password,
      );

      print("REGISTER RESULT:");
      print(result);

      return result["success"] == true;
    } catch (e) {
      print("REGISTER ERROR:");
      print(e);

      return false;
    }
  }
}