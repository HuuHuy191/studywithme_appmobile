import 'package:flutter/material.dart';

import '../../controllers/quiz_controller.dart';
import '../../models/quiz_model.dart';

class DoQuizScreen extends StatefulWidget {

  final int quizId;

  const DoQuizScreen({
    super.key,
    required this.quizId,
  });

  @override
  State<DoQuizScreen> createState() =>
      _DoQuizScreenState();
}

class _DoQuizScreenState
    extends State<DoQuizScreen> {

  final QuizController controller =
  QuizController();

  QuizModel? quiz;

  bool loading = true;
  int currentQuestion = 0;

  String? selectedAnswer;
  Map<int, String> answers = {};
  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  Future<void> loadQuiz() async {

    quiz = await controller.getQuizDetail(
      widget.quizId,
    );

    setState(() {
      loading = false;
    });

  }
  int calculateScore() {

    int score = 0;

    for (int i = 0; i < quiz!.questions.length; i++) {

      if (answers[i] ==
          quiz!.questions[i].correctAnswer) {

        score++;

      }

    }

    return score;

  }

  @override
  Widget build(BuildContext context) {

    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      appBar: AppBar(
        title: Text(quiz!.title),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(

              "Câu ${currentQuestion + 1}/${quiz!.questions.length}",

              style: const TextStyle(

                fontSize: 20,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 20),

            Text(

              quiz!.questions[currentQuestion].question,

              style: const TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.w500,

              ),

            ),
            const SizedBox(height: 20),

            RadioListTile<String>(

              title: Text(
                quiz!.questions[currentQuestion].optionA,
              ),

              value: "A",

              groupValue: selectedAnswer,

              onChanged: (value) {

                setState(() {

                  selectedAnswer = value;
                  answers[currentQuestion] = value!;

                });

              },

            ),

            RadioListTile<String>(

              title: Text(
                quiz!.questions[currentQuestion].optionB,
              ),

              value: "B",

              groupValue: selectedAnswer,

              onChanged: (value) {

                setState(() {

                  selectedAnswer = value;
                  answers[currentQuestion] = value!;


                });

              },

            ),

            RadioListTile<String>(

              title: Text(
                quiz!.questions[currentQuestion].optionC,
              ),

              value: "C",

              groupValue: selectedAnswer,

              onChanged: (value) {

                setState(() {

                  selectedAnswer = value;
                  answers[currentQuestion] = value!;


                });

              },

            ),

            RadioListTile<String>(

              title: Text(
                quiz!.questions[currentQuestion].optionD,
              ),

              value: "D",

              groupValue: selectedAnswer,

              onChanged: (value) {

                setState(() {

                  selectedAnswer = value;
                  answers[currentQuestion] = value!;

                });

              },

            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                child: Text(

                  currentQuestion ==
                      quiz!.questions.length - 1

                      ? "Nộp bài"

                      : "Tiếp theo",

                ),

                onPressed: () {

                  if (selectedAnswer == null) {

                    ScaffoldMessenger.of(context)

                        .showSnackBar(

                      const SnackBar(

                        content: Text(

                          "Hãy chọn đáp án",

                        ),

                      ),

                    );

                    return;

                  }

                  if (currentQuestion ==

                      quiz!.questions.length - 1) {
                    int score = calculateScore();

                    showDialog(

                      context: context,

                      barrierDismissible: false,

                      builder: (_) {

                        return AlertDialog(

                          title: const Text("Kết quả"),

                          content: Text(

                            "Bạn đúng $score/${quiz!.questions.length} câu.",

                          ),

                          actions: [

                            ElevatedButton(

                              onPressed: () {

                                Navigator.pop(context);

                                Navigator.pop(context);

                              },

                              child: const Text("Hoàn thành"),

                            ),

                          ],

                        );

                      },

                    );

                    // TODO

                  } else {

                    setState(() {

                      currentQuestion++;

                      selectedAnswer =

                      answers[currentQuestion];

                    });

                  }

                },

              ),

            ),

          ],

        ),

      ),

    );

  }

}