import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import 'register_screen.dart';
import '../../controllers/auth_controller.dart';
import '../home/home_screen.dart';
import '../mainscreen/mainScreen.dart';
class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _securityMessage;
  bool _isLocked = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  Future<void> login() async {
    final result = await _authController.login(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );

    bool success = result['success'] ?? false;
    String message = result['message'] ?? "Đăng nhập thất bại";

    print("LOGIN SUCCESS = $success");

    if (success) {
      setState(() {

        _securityMessage = message;

        if (
        message.contains("locked") ||
            message.contains("khóa")
        ) {
          _isLocked = true;
        }

      });


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainScreen(),
        ),
      );
    } else {
      // HIỂN THỊ CHÍNH XÁC TIN NHẮN TỪ SERVER (Ví dụ: Còn x lần thử, Đang bị khóa...)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // Chuyển sang nền trắng tinh khôi
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header với màu Primary và bo góc tròn lớn phía dưới
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_stories, size: 70, color: AppColors.white),
                  SizedBox(height: 10),
                  Text(
                    "Study With Me",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Đăng nhập",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 5),
                  const Text("Vui lòng đăng nhập để tiếp tục",
                      style: TextStyle(color: AppColors.grey)),
                  const SizedBox(height: 15),

                  if (_securityMessage != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _isLocked
                            ? Colors.red.shade50
                            : Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isLocked
                              ? Colors.red
                              : Colors.orange,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Icon(
                            _isLocked
                                ? Icons.lock
                                : Icons.warning_amber_rounded,
                            color: _isLocked
                                ? Colors.red
                                : Colors.orange,
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              _securityMessage!,
                              style: TextStyle(
                                color: _isLocked
                                    ? Colors.red
                                    : Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 40),

                  // Ô nhập Tên tài khoản
                  _buildInputLabel("Email"),
                  CustomTextField(
                    controller: _usernameController,
                    hint: "Nhập email của bạn",
                  ),

                  const SizedBox(height: 25),

                  // Ô nhập Mật khẩu
                  _buildInputLabel("Mật khẩu"),
                  CustomTextField(
                    controller: _passwordController,
                    hint: "Nhập mật khẩu",
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Quên mật khẩu?",
                          style: TextStyle(color: AppColors.primary)),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Nút đăng nhập chính
                  CustomButton(
                    text: _isLocked
                        ? "🔒 TÀI KHOẢN ĐANG BỊ KHÓA"
                        : "VÀO HỌC NGAY",

                    onPressed: _isLocked
                        ? null
                        : () {
                      login();
                    },
                  ),

                  const SizedBox(height: 40),




                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Chưa có tài khoản? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Đăng ký",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hỗ trợ vẽ nhãn chữ nhỏ bên trên ô nhập
  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.grey,
        ),
      ),
    );
  }

  // Widget vẽ các nút icon MXH
  Widget _socialIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.background),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon, size: 35, color: color),
    );
  }
}