class MemberModel {
  final int id;
  final String email;
  final String role;

  MemberModel({
    required this.id,
    required this.email,
    required this.role,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json["User"]["id"],
      email: json["User"]["email"],
      role: json["role"],
    );
  }
}