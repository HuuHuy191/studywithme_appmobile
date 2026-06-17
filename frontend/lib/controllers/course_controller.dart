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
      ) async {

    CourseModel course =
    CourseModel(
      name: name,
      description: description,
      classCode: "",
    );

    return await _service
        .createCourse(course);
  }
}