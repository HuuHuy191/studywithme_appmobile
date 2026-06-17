class CourseModel {

  final int? id;

  final String name;

  final String description;

  final String classCode;

  CourseModel({
    this.id,
    required this.name,
    required this.description,
    required this.classCode,
  });

  factory CourseModel.fromJson(
      Map<String, dynamic> json) {

    return CourseModel(

      id: json["id"],

      name: json["name"] ?? "",

      description:
      json["description"] ?? "",

      classCode:
      json["classCode"] ?? "",

    );
  }

  Map<String, dynamic> toJson() {

    return {

      "name": name,

      "description":
      description,

    };
  }
}