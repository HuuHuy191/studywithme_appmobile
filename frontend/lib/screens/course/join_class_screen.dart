import 'package:flutter/material.dart';

import '../../controllers/class_member_controller.dart';

import '../../models/course_model.dart';
import 'class_detail_screen.dart';

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

  List<CourseModel> joinedClasses = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadJoinedClasses();
  }
  Future<void> loadJoinedClasses() async {

    try {

      joinedClasses =
      await controller.getJoinedClasses();

    } catch (e) {

      debugPrint(e.toString());

    }

    setState(() {
      isLoading = false;
    });
  }

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

      await loadJoinedClasses();

      codeController.clear();

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
              width: double.infinity,

              child: ElevatedButton(
                onPressed: joinClass,
                child: const Text(
                  "Tham gia",
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Các lớp đã tham gia",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : joinedClasses.isEmpty
                  ? const Center(
                child: Text(
                  "Bạn chưa tham gia lớp nào",
                ),
              )
                  : ListView.builder(
                itemCount: joinedClasses.length,
                itemBuilder: (context, index) {

                  final classroom =
                  joinedClasses[index];

                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.class_,
                      ),

                      title: Text(
                        classroom.name,
                      ),

                      subtitle: Text(
                        "Mã lớp: ${classroom.classCode}",
                      ),

                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                      ),

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                ClassDetailScreen(
                                  classroom:
                                  classroom,
                                ),

                          ),

                        );

                      },
                    ),
                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}