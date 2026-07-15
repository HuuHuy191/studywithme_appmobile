class QuizQuestionModel {
  int? id;
  int? quizId;

  String question;

  String optionA;
  String optionB;
  String optionC;
  String optionD;

  String correctAnswer;

  QuizQuestionModel({
    this.id,
    this.quizId,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctAnswer,
  });

  factory QuizQuestionModel.fromJson(
      Map<String, dynamic> json) {
    return QuizQuestionModel(
      id: json["id"],
      quizId: json["quizId"],
      question: json["question"],
      optionA: json["optionA"],
      optionB: json["optionB"],
      optionC: json["optionC"],
      optionD: json["optionD"],
      correctAnswer: json["correctAnswer"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "quizId": quizId,
      "question": question,
      "optionA": optionA,
      "optionB": optionB,
      "optionC": optionC,
      "optionD": optionD,
      "correctAnswer": correctAnswer,
    };
  }
}