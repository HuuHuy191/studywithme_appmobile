import 'package:flutter/material.dart';

import '../../models/quiz_model.dart';

class EditQuizScreen extends StatefulWidget {

  final QuizModel quiz;

  const EditQuizScreen({
    super.key,
    required this.quiz,
  });

  @override
  State<EditQuizScreen> createState() =>
      _EditQuizScreenState();
}

class _EditQuizScreenState
    extends State<EditQuizScreen> {
  late TextEditingController titleController;

  late TextEditingController descriptionController;
  @override
  void initState() {

    super.initState();

    titleController = TextEditingController(
      text: widget.quiz.title,
    );

    descriptionController = TextEditingController(
      text: widget.quiz.description,
    );

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Sửa Quiz"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              controller: titleController,

              decoration: const InputDecoration(
                labelText: "Tên Quiz",
              ),

            ),

            const SizedBox(height: 20),

            TextField(

              controller: descriptionController,

              decoration: const InputDecoration(
                labelText: "Mô tả",
              ),

            ),

          ],

        ),

      ),

    );

  }

}