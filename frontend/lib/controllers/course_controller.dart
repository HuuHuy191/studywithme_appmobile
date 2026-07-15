import '../models/course_model.dart';
import '../services/course_service.dart';

class CourseController {

  final CourseService _service =
  CourseService();

  Future<List<CourseModel>>
  getCourses() async {

    return await _service.getCourses();
  }

  Future<bool> createCourse(
      String name,
      String description,
      int maxMembers,
      ) async {

    CourseModel course =
    CourseModel(
      name: name,
      description: description,
      classCode: "",
      maxMembers: maxMembers,
    );

    return await _service
        .createCourse(course);
  }
  Future<bool> joinClass(
      String classCode,
      ) async {

    return await _service.joinClass(
      classCode,
    );

  }
  Future<bool> updateCourse(

      int courseId,

      String description,

      int maxMembers,

      ) async {

    return await _service.updateCourse(

      courseId,

      description,

      maxMembers,

    );

  }
  Future<CourseModel> getCourseDetail(
      int id) async {

    return await _service.getCourseDetail(id);

  }
}