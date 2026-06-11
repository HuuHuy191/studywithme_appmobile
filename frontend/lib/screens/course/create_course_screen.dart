import 'package:flutter/material.dart';

import '../../controllers/course_controller.dart';

class CreateCourseScreen
    extends StatefulWidget {

  const CreateCourseScreen({
    super.key,
  });

  @override
  State<CreateCourseScreen>
  createState() =>
      _CreateCourseScreenState();
}

class _CreateCourseScreenState
    extends State<CreateCourseScreen> {

  final titleController =
  TextEditingController();

  final CourseController controller =
  CourseController();

  String selectedType = "vocab";

  Future<void> saveCourse() async {

    bool success =
    await controller.createCourse(
      titleController.text,
      selectedType,
    );

    if (success) {

      Navigator.pop(context, true);

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("Tạo thất bại"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        const Text("Tạo lớp học"),
      ),
      body: Padding(
        padding:
        const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller:
              titleController,
              decoration:
              const InputDecoration(
                labelText:
                "Tên lớp học",
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            DropdownButtonFormField(
              value: selectedType,
              items: const [

                DropdownMenuItem(
                  value: "vocab",
                  child: Text(
                    "Từ vựng",
                  ),
                ),

                DropdownMenuItem(
                  value: "quiz",
                  child: Text(
                    "Quiz",
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType =
                  value!;
                });
              },
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                saveCourse,
                child: const Text(
                  "Tạo lớp học",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}