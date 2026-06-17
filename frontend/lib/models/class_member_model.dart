class ClassMemberModel {
  final int? id;
  final int classroomId;
  final int userId;

  ClassMemberModel({
    this.id,
    required this.classroomId,
    required this.userId,
  });

  factory ClassMemberModel.fromJson(
      Map<String, dynamic> json) {
    return ClassMemberModel(
      id: json["id"],
      classroomId: json["classroomId"],
      userId: json["userId"],
    );
  }
}