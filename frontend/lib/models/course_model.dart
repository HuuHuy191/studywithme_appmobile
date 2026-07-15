class CourseModel {
  final int? id;

  final String name;

  final String description;

  final String classCode;
  final int? ownerId;
  final int maxMembers;

  CourseModel({
    this.id,
    required this.name,
    required this.description,
    required this.classCode,
    required this.maxMembers,
    this.ownerId,
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
      maxMembers: json["maxMembers"] ?? 30,
      ownerId: json["ownerId"],
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "name": name,

      "description":
      description,
      "maxMembers": maxMembers,
    };
  }
}