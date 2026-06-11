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
      String title,
      String type) async {

    CourseModel course =
    CourseModel(
      id: "",
      title: title,
      type: type,
    );

    return await _service
        .createCourse(course);
  }
}