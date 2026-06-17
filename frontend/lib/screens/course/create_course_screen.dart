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

  final nameController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  final CourseController controller =
  CourseController();

  Future<void> saveCourse() async {

    if (nameController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Vui lòng nhập tên lớp",
          ),
        ),
      );

      return;
    }

    bool success =
    await controller.createCourse(
      nameController.text.trim(),
      descriptionController.text.trim(),
    );

    if (success) {

      Navigator.pop(context, true);

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("Tạo lớp thất bại"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Tạo lớp học",
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller:
              nameController,

              decoration:
              const InputDecoration(
                labelText:
                "Tên lớp học",
                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            TextField(
              controller:
              descriptionController,

              maxLines: 3,

              decoration:
              const InputDecoration(
                labelText:
                "Mô tả lớp học",
                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
              width: double.infinity,

              child:
              ElevatedButton(

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