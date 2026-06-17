import '../services/class_member_service.dart';

class ClassMemberController {

  final ClassMemberService _service =
  ClassMemberService();

  Future<bool> joinClass(
      String classCode) async {

    return await _service.joinClass(
      classCode,
    );
  }
}