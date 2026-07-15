import 'package:flutter/material.dart';

import '../../controllers/quiz_controller.dart';
import '../../models/course_model.dart';
import '../../models/quiz_model.dart';
import 'do_quiz_screen.dart';

class QuizListScreen extends StatefulWidget {
  final CourseModel classroom;
  final bool isOwner;

  const QuizListScreen({
    super.key,
    required this.classroom,
    required this.isOwner,
  });

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  final QuizController controller = QuizController();

  List<QuizModel> quizzes = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  Future<void> loadQuiz() async {
    try {
      quizzes = await controller.getQuizzes(
        widget.classroom.id!,
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz - ${widget.classroom.name}"),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : quizzes.isEmpty
          ? const Center(
        child: Text("Lớp này chưa có Quiz"),
      )
          : ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: const Icon(Icons.quiz),

              title: Text(quiz.title),

              subtitle: Text(quiz.description),

              trailing: widget.isOwner
                  ? IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  showQuizMenu(quiz);
                },
              )
                  : const Icon(Icons.arrow_forward_ios),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DoQuizScreen(
                      quizId: quiz.id!,
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

  void showQuizMenu(QuizModel quiz) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.play_arrow),
                title: const Text("Làm Quiz"),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DoQuizScreen(
                        quizId: quiz.id!,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Sửa Quiz"),
                onTap: () {
                  Navigator.pop(context);

                  // TODO:
                  // Mở CreateQuizScreen để sửa
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Xóa Quiz"),
                onTap: () async {
                  Navigator.pop(context);

                  bool success =
                  await controller.deleteQuiz(
                    quiz.id!,
                  );

                  if (success) {
                    await loadQuiz();

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Đã xóa Quiz"),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}