import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/course_model.dart';
import '../../models/quiz_question_model.dart';
import '../../controllers/quiz_controller.dart';
import '../../models/quiz_model.dart';
class CreateQuizScreen extends StatefulWidget {

  final CourseModel classroom;

  final QuizModel? quiz;

  const CreateQuizScreen({

    super.key,

    required this.classroom,

    this.quiz,

  });

  @override
  State<CreateQuizScreen> createState() =>
      _CreateQuizScreenState();

}

class _CreateQuizScreenState
    extends State<CreateQuizScreen> {
  final QuizController controller = QuizController();
  Future<void> saveQuiz() async {

    if (titleController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text("Nhập tên Quiz"),

        ),

      );

      return;

    }

    if (questions.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text("Quiz phải có ít nhất 1 câu hỏi"),

        ),

      );

      return;

    }

    QuizModel quiz = QuizModel(

      title: titleController.text,

      description: descriptionController.text,

      courseId: widget.classroom.id!,

      questions: questions,

    );

    bool success =
    await controller.createFullQuiz(quiz);

    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text("Tạo Quiz thành công"),

        ),

      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text("Tạo Quiz thất bại"),

        ),

      );

    }

  }

  Future<void> updateQuiz() async {

    QuizModel quiz = QuizModel(

      id: widget.quiz!.id,

      title: titleController.text,

      description: descriptionController.text,

      courseId: widget.classroom.id!,

      questions: questions,

    );

    bool success =
    await controller.updateQuiz(quiz);

    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Cập nhật thành công",
          ),

        ),

      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Cập nhật thất bại",
          ),

        ),

      );

    }

  }
  final titleController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  List<QuizQuestionModel> questions = [];

  @override
  void initState() {

    super.initState();

    if (widget.quiz != null) {

      titleController.text =
          widget.quiz!.title;

      descriptionController.text =
          widget.quiz!.description;

      questions =
          widget.quiz!.questions;

    } else {

      addQuestion();

    }

  }

  void addQuestion() {

    setState(() {

      questions.add(

        QuizQuestionModel(

          question: "",

          optionA: "",

          optionB: "",

          optionC: "",

          optionD: "",

          correctAnswer: "A",

        ),

      );

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(

          widget.quiz == null

              ? "Tạo Quiz"

              : "Sửa Quiz",

        ),

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              controller: titleController,

              decoration: const InputDecoration(

                labelText: "Tên Quiz",

                border: OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 20),

            TextField(

              controller: descriptionController,

              maxLines: 3,

              decoration: const InputDecoration(

                labelText: "Mô tả",

                border: OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 30),

            ListView.builder(

              shrinkWrap: true,

              physics:
              const NeverScrollableScrollPhysics(),

              itemCount: questions.length,

              itemBuilder: (context, index) {

                return QuestionCard(

                  index: index,

                  question: questions[index],

                  onDelete: () {

                    setState(() {

                      questions.removeAt(index);

                    });

                  },

                );

              },

            ),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(Icons.add),

                label: const Text(
                  "Thêm câu hỏi",
                ),

                onPressed: addQuestion,

              ),

            ),

            const SizedBox(height: 20),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  if (widget.quiz == null) {

                    saveQuiz();


                  } else {

                    updateQuiz();

                  }

                },

                child: Text(

                  widget.quiz == null

                      ? "Tạo Quiz"

                      : "Lưu thay đổi",

                ),

              )

            ),

          ],

        ),

      ),

    );

  }

}
class QuestionCard extends StatefulWidget {

  final int index;

  final QuizQuestionModel question;

  final VoidCallback onDelete;

  const QuestionCard({

    super.key,

    required this.index,

    required this.question,

    required this.onDelete,

  });

  @override
  State<QuestionCard> createState() =>
      _QuestionCardState();

}
class _QuestionCardState
    extends State<QuestionCard> {

  late TextEditingController questionController;

  late TextEditingController optionAController;

  late TextEditingController optionBController;

  late TextEditingController optionCController;

  late TextEditingController optionDController;

  @override
  void initState() {
    super.initState();

    questionController =
        TextEditingController(
            text: widget.question.question);

    optionAController =
        TextEditingController(
            text: widget.question.optionA);

    optionBController =
        TextEditingController(
            text: widget.question.optionB);

    optionCController =
        TextEditingController(
            text: widget.question.optionC);

    optionDController =
        TextEditingController(
            text: widget.question.optionD);
  }

  @override
  Widget build(BuildContext context) {
    return Card(

      margin:
      const EdgeInsets.only(bottom: 20),

      child: Padding(

        padding:
        const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(

              "Câu hỏi ${widget.index + 1}",

              style: const TextStyle(

                fontSize: 18,

                fontWeight:
                FontWeight.bold,

              ),

            ),

            const SizedBox(height: 15),

            TextField(

              controller:
              questionController,

              decoration:
              const InputDecoration(

                labelText:
                "Nội dung câu hỏi",

              ),

              onChanged: (value) {
                widget.question.question =
                    value;
              },

            ),

            const SizedBox(height: 10),

            TextField(

              controller:
              optionAController,

              decoration:
              const InputDecoration(

                labelText:
                "Đáp án A",

              ),

              onChanged: (value) {
                widget.question.optionA =
                    value;
              },

            ),

            const SizedBox(height: 10),

            TextField(

              controller:
              optionBController,

              decoration:
              const InputDecoration(

                labelText:
                "Đáp án B",

              ),

              onChanged: (value) {
                widget.question.optionB =
                    value;
              },

            ),

            const SizedBox(height: 10),

            TextField(

              controller:
              optionCController,

              decoration:
              const InputDecoration(

                labelText:
                "Đáp án C",

              ),

              onChanged: (value) {
                widget.question.optionC =
                    value;
              },

            ),

            const SizedBox(height: 10),

            TextField(

              controller:
              optionDController,

              decoration:
              const InputDecoration(

                labelText:
                "Đáp án D",

              ),

              onChanged: (value) {
                widget.question.optionD =
                    value;
              },

            ),
            const SizedBox(height: 20),

            const Text(
              "Đáp án đúng",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioListTile<String>(
              value: "A",
              groupValue: widget.question.correctAnswer,
              title: const Text("Đáp án A"),
              onChanged: (value) {
                setState(() {
                  widget.question.correctAnswer = value!;
                });
              },
            ),

            RadioListTile<String>(
              value: "B",
              groupValue: widget.question.correctAnswer,
              title: const Text("Đáp án B"),
              onChanged: (value) {
                setState(() {
                  widget.question.correctAnswer = value!;
                });
              },
            ),

            RadioListTile<String>(
              value: "C",
              groupValue: widget.question.correctAnswer,
              title: const Text("Đáp án C"),
              onChanged: (value) {
                setState(() {
                  widget.question.correctAnswer = value!;
                });
              },
            ),

            RadioListTile<String>(
              value: "D",
              groupValue: widget.question.correctAnswer,
              title: const Text("Đáp án D"),
              onChanged: (value) {
                setState(() {
                  widget.question.correctAnswer = value!;
                });
              },
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: const Text(
                  "Xóa câu hỏi",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: widget.onDelete,
              ),
            ),

          ],

        ),

      ),

    );
  }
}