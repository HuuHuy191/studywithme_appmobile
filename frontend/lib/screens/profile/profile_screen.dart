import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final authController =
    AuthController();

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
      ),

      body: Center(

        child: ElevatedButton.icon(

          icon: const Icon(
            Icons.logout,
          ),

          label: const Text(
            "Đăng xuất",
          ),

          onPressed: () async {

            await authController
                .logout();

            Navigator.pushAndRemoveUntil(

              context,

              MaterialPageRoute(
                builder: (_) =>
                const LoginScreen(),
              ),

                  (route) => false,
            );
          },
        ),
      ),
    );
  }
}