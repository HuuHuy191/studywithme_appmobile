import '../models/course_model.dart';
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

  // Lấy danh sách lớp đã tham gia
  Future<List<CourseModel>> getJoinedClasses() async {

    return await _service.getJoinedClasses();

  }
}