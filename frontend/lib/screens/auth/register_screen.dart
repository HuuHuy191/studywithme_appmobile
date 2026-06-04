import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController(); // Thêm tên đăng nhập
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final otpController = TextEditingController(); // Thêm controller OTP

  void register() {
    // Kiểm tra logic cơ bản
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passController.text.isEmpty
        // || otpController.text.isEmpty
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng điền đầy đủ các thông tin")),
      );
      return;
    }

    if (passController.text != confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mật khẩu xác nhận không khớp")),
      );
      return;
    }

    // Trả dữ liệu về màn hình Login (bao gồm username để điền sẵn)
    Navigator.pop(context, {
      'username': usernameController.text,
      'password': passController.text,
      'email': emailController.text,
    });
  }

  // void sendOTP() {
  //   // Logic gửi mã OTP xử lý ở đây
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("Mã OTP đã được gửi đến ${emailController.text}")),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Tạo tài khoản"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Text(
                "Đăng ký thành viên",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
              ),
              SizedBox(height: 25),

              // Form Đăng ký
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 8))
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Tên đăng nhập
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "Tên đăng nhập",
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(height: 15),

                    // Email
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(height: 15),

                    // Hàng nhập OTP
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 2,
                    //       child: TextField(
                    //         controller: otpController,
                    //         decoration: InputDecoration(
                    //           labelText: "Mã OTP",
                    //           prefixIcon: Icon(Icons.verified_user_outlined),
                    //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 10),
                    //     Expanded(
                    //       flex: 1,
                    //       child: SizedBox(
                    //         height: 55,
                    //         child: ElevatedButton(
                    //           onPressed: sendOTP,
                    //           style: ElevatedButton.styleFrom(
                    //             backgroundColor: Colors.orangeAccent,
                    //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    //             padding: EdgeInsets.zero,
                    //           ),
                    //           child: Text("Gửi mã", style: TextStyle(color: Colors.white, fontSize: 13)),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 15),

                    // Mật khẩu
                    TextField(
                      controller: passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Mật khẩu",
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(height: 15),

                    // Nhập lại mật khẩu
                    TextField(
                      controller: confirmPassController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Nhập lại mật khẩu",
                        prefixIcon: Icon(Icons.lock_reset),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Nút Đăng ký
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                  ),
                  child: Text(
                    "ĐĂNG KÝ NGAY",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 15),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Đã có tài khoản? Quay lại đăng nhập", style: TextStyle(color: Colors.blueGrey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}