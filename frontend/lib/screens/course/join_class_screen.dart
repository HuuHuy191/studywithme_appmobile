import 'package:flutter/material.dart';

import '../../controllers/class_member_controller.dart';

class JoinClassScreen
    extends StatefulWidget {

  const JoinClassScreen({
    super.key,
  });

  @override
  State<JoinClassScreen>
  createState() =>
      _JoinClassScreenState();
}

class _JoinClassScreenState
    extends State<JoinClassScreen> {

  final codeController =
  TextEditingController();

  final controller =
  ClassMemberController();

  Future<void> joinClass() async {

    bool success =
    await controller.joinClass(
      codeController.text.trim(),
    );

    if (success) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Tham gia thành công",
          ),
        ),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Mã lớp không hợp lệ",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text(
          "Tham gia lớp",
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller:
              codeController,

              decoration:
              const InputDecoration(
                labelText:
                "Nhập mã lớp",
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width:
              double.infinity,

              child:
              ElevatedButton(
                onPressed:
                joinClass,

                child:
                const Text(
                  "Tham gia",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}