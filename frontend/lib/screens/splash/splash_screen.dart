import 'package:flutter/material.dart';

import '../../core/utils/storage_helper.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';
import '../mainscreen/mainScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {

    await Future.delayed(
      const Duration(seconds: 2),
    );

    String? token =
    await StorageHelper.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const MainScreen(),
        ),
      );

    } else {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: const [

            Icon(
              Icons.school,
              size: 100,
            ),

            SizedBox(height: 20),

            Text(
              "Study With Me",
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}