import 'package:flutter/material.dart';

import '../../controllers/quiz_controller.dart';
import '../../models/quiz_group_model.dart';
import '../../models/quiz_model.dart';
import '../quiz/do_quiz_screen.dart';
import 'edit_quiz_screen.dart';
class QuizHomeScreen extends StatefulWidget {
  const QuizHomeScreen({super.key});

  @override
  State<QuizHomeScreen> createState() =>
      _QuizHomeScreenState();
}

class _QuizHomeScreenState
    extends State<QuizHomeScreen> {

  final QuizController controller =
  QuizController();

  List<QuizGroupModel> groups = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    try {

      groups =
      await controller.getMyQuizzes();

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
        title: const Text("Quiz"),
      ),

      body: isLoading

          ? const Center(
        child:
        CircularProgressIndicator(),
      )

          : ListView.builder(

        itemCount: groups.length,

        itemBuilder:
            (context, index) {

          final group =
          groups[index];

          return Card(

            margin:
            const EdgeInsets.all(10),

            child: ExpansionTile(

              leading: const Icon(
                  Icons.school),

              title:
              Text(group.courseName),

              subtitle: Text(
                "${group.quizzes.length} Quiz",
              ),

              children: group.quizzes

                  .map(
                    (quiz) =>
                    buildQuizTile(
                      group,
                      quiz,
                    ),
              )

                  .toList(),

            ),

          );

        },

      ),

    );

  }

  Widget buildQuizTile(

      QuizGroupModel group,

      QuizModel quiz) {

    return ListTile(

      leading:
      const Icon(Icons.quiz),

      title:
      Text(quiz.title),

      subtitle:
      Text(quiz.description),

      trailing:
      const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),

      onTap: () {

        showModalBottomSheet(

          context: context,

          builder: (_) =>

              buildQuizMenu(
                group,
                quiz,
              ),

        );

      },

    );

  }

  Widget buildQuizMenu(

      QuizGroupModel group,

      QuizModel quiz) {

    return SafeArea(

      child: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          mainAxisSize:
          MainAxisSize.min,

          children: [

            Text(

              quiz.title,

              style:
              const TextStyle(

                fontSize: 22,

                fontWeight:
                FontWeight.bold,

              ),

            ),

            const SizedBox(height: 20),

            ListTile(

              leading: const Icon(
                  Icons.play_arrow),

              title:
              const Text("Làm Quiz"),

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

            if (group.owner)

              ListTile(

                leading:
                const Icon(Icons.edit),

                title: const Text(
                    "Sửa Quiz"),

                onTap: () {

                  Navigator.pop(context);

                  // TODO
                  // Sang EditQuizScreen
                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => EditQuizScreen(

                        quiz: quiz,

                      ),

                    ),

                  ).then((_){

                    loadData();

                  });

                },

              ),

            if (group.owner)

              ListTile(

                leading:
                const Icon(Icons.delete),

                title: const Text(
                    "Xóa Quiz"),

                onTap: () async {

                  Navigator.pop(context);

                  final ok =
                  await showDialog<bool>(

                    context: context,

                    builder: (_) {

                      return AlertDialog(

                        title: const Text(
                            "Xóa Quiz"),

                        content: const Text(
                            "Bạn có chắc muốn xóa Quiz này không?"),

                        actions: [

                          TextButton(

                            onPressed: () {

                              Navigator.pop(
                                  context,
                                  false);

                            },

                            child:
                            const Text("Hủy"),

                          ),

                          ElevatedButton(

                            onPressed: () {

                              Navigator.pop(
                                  context,
                                  true);

                            },

                            child:
                            const Text("Xóa"),

                          ),

                        ],

                      );

                    },

                  );

                  if (ok == true) {

                    bool success =
                    await controller
                        .deleteQuiz(
                      quiz.id!,
                    );

                    if (success) {

                      await loadData();

                      ScaffoldMessenger.of(
                          context)

                          .showSnackBar(

                        const SnackBar(

                          content: Text(
                              "Đã xóa Quiz"),

                        ),

                      );

                    }

                  }

                },

              ),

          ],

        ),

      ),

    );

  }

}