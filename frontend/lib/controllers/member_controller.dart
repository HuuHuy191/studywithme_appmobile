import '../models/member_model.dart';
import '../services/member_service.dart';

class MemberController {

  final MemberService _service =
  MemberService();

  Future<List<MemberModel>>
  getMembers(int classId) async {

    return await _service.getMembers(classId);

  }
  Future<bool> removeMember(
      int classId,
      int userId,
      ) async {

    return await _service.removeMember(
      classId,
      userId,
    );

  }
}