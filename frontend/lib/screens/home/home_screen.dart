import 'package:flutter/material.dart';

import '../../controllers/course_controller.dart';
import '../../models/course_model.dart';
import '../course/create_course_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  final CourseController controller =
  CourseController();

  List<CourseModel> courses = [];

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  Future<void> loadCourses() async {

    courses =
    await controller.getCourses();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Study With Me",
        ),
      ),

      floatingActionButton:
      FloatingActionButton(
        child:
        const Icon(Icons.add),
        onPressed: () async {

          final result =
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const CreateCourseScreen(),
            ),
          );

          if (result == true) {
            loadCourses();
          }
        },
      ),

      body: ListView.builder(
        itemCount: courses.length,

        itemBuilder:
            (context, index) {

          final course =
          courses[index];

          return Card(
            child: ListTile(

              title: Text(
                course.title,
              ),

              subtitle: Text(
                course.type,
              ),
            ),
          );
        },
      ),
    );
  }
}