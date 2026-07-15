import 'quiz_model.dart';

class QuizGroupModel {

  final int courseId;

  final String courseName;

  final bool owner;

  final List<QuizModel> quizzes;

  QuizGroupModel({

    required this.courseId,

    required this.courseName,

    required this.owner,

    required this.quizzes,

  });

  factory QuizGroupModel.fromJson(
      Map<String, dynamic> json) {

    return QuizGroupModel(

      courseId: json["courseId"],

      courseName: json["courseName"],

      owner: json["owner"],

      quizzes: (json["quizzes"] as List)

          .map(
            (e) => QuizModel.fromJson(e),
      )

          .toList(),

    );

  }

}