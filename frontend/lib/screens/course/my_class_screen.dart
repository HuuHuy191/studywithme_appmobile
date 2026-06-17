import 'package:flutter/material.dart';

import '../../controllers/course_controller.dart';
import '../../models/course_model.dart';
import 'class_detail_screen.dart';
import '../course/create_course_screen.dart';

class MyClassScreen extends StatefulWidget {
  const MyClassScreen({super.key});

  @override
  State<MyClassScreen> createState() =>
      _MyClassScreenState();
}

class _MyClassScreenState
    extends State<MyClassScreen> {

  final CourseController controller =
  CourseController();

  List<CourseModel> classes = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadClasses();
  }

  Future<void> loadClasses() async {

    setState(() {
      isLoading = true;
    });

    try {

      classes =
      await controller.getCourses();

    } catch (e) {

      debugPrint(
        e.toString(),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      floatingActionButton:
      FloatingActionButton(

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
            loadClasses();
          }
        },

        child: const Icon(
          Icons.add,
        ),
      ),

      body: isLoading

          ? const Center(
        child:
        CircularProgressIndicator(),
      )

          : classes.isEmpty

          ? const Center(
        child: Text(
          "Bạn chưa tạo lớp nào",
        ),
      )

          : ListView.builder(

        padding:
        const EdgeInsets.all(
          10,
        ),

        itemCount:
        classes.length,

        itemBuilder:
            (context, index) {

          final classroom =
          classes[index];

          return Card(

            elevation: 3,

            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                12,
              ),
            ),

            margin:
            const EdgeInsets.only(
              bottom: 12,
            ),

            child: ListTile(

              leading:
              const CircleAvatar(
                child: Icon(
                  Icons.class_,
                ),
              ),

              title: Text(
                classroom.name,
              ),

              subtitle: Text(
                "Mã lớp: ${classroom.classCode}",
              ),

              trailing:
              const Icon(
                Icons
                    .arrow_forward_ios,
                size: 18,
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
    );
  }
}