class VocabModel {
  final int? id;

  final String word;

  final String meaning;

  final String example;

  final int courseId;

  VocabModel({
    this.id,
    required this.word,
    required this.meaning,
    required this.example,
    required this.courseId,
  });

  factory VocabModel.fromJson(
      Map<String, dynamic> json) {

    return VocabModel(

      id: json["id"],

      word: json["word"],

      meaning: json["meaning"],

      example: json["example"] ?? "",

      courseId: json["courseId"],

    );

  }

  Map<String, dynamic> toJson() {

    return {

      "word": word,

      "meaning": meaning,

      "example": example,

      "courseId": courseId,

    };

  }

}