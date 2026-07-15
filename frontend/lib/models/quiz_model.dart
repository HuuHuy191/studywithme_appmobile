import 'quiz_question_model.dart';

class QuizModel {
  int? id;

  String title;

  String description;

  int courseId;

  List<QuizQuestionModel> questions;

  QuizModel({
    this.id,
    required this.title,
    required this.description,
    required this.courseId,
    this.questions = const [],
  });

  factory QuizModel.fromJson(
      Map<String, dynamic> json) {
    return QuizModel(
      id: json["id"],
      title: json["title"],
      description: json["description"] ?? "",
      courseId: json["courseId"],
      questions: json["questions"] == null
          ? []
          : (json["questions"] as List)
          .map(
            (e) => QuizQuestionModel.fromJson(e),
      )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "courseId": courseId,
      "questions":
      questions.map((e) => e.toJson()).toList(),
    };
  }
}