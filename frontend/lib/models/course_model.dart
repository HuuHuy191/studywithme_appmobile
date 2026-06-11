class CourseModel {
  final String id;
  final String title;
  final String type;

  CourseModel({
    required this.id,
    required this.title,
    required this.type,
  });

  factory CourseModel.fromJson(
      Map<String, dynamic> json) {
    return CourseModel(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      type: json["type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "type": type,
    };
  }
}