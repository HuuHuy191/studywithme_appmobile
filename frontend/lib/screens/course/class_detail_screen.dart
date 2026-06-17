import 'package:flutter/material.dart';

import '../../models/course_model.dart';

class ClassDetailScreen
    extends StatelessWidget {

  final CourseModel classroom;

  const ClassDetailScreen({
    super.key,
    required this.classroom,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          classroom.name,
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            Card(
              child: ListTile(
                title: Text(
                  classroom.name,
                ),
                subtitle: Text(
                  "Mã lớp: ${classroom.classCode}",
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width:
              double.infinity,

              child:
              ElevatedButton.icon(

                icon: const Icon(
                  Icons.menu_book,
                ),

                label: const Text(
                  "Vocabulary",
                ),

                onPressed: () {

                  // TODO
                },
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            SizedBox(
              width:
              double.infinity,

              child:
              ElevatedButton.icon(

                icon: const Icon(
                  Icons.quiz,
                ),

                label: const Text(
                  "Quiz",
                ),

                onPressed: () {

                  // TODO
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}