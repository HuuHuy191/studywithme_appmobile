import '../models/quiz_model.dart';
import '../services/quiz_service.dart';
import '../models/quiz_group_model.dart';
class QuizController {

  final QuizService _service =
  QuizService();

  // Lấy danh sách Quiz
  Future<List<QuizModel>> getQuizzes(
      int courseId) async {

    return await _service.getQuizzes(
      courseId,
    );

  }
  // Lấy tất cả Quiz của các lớp đã tham gia
  Future<List<QuizGroupModel>> getMyQuizzes() async {

    return await _service.getMyQuizzes();

  }
  // Tạo Quiz + Question
  Future<bool> createFullQuiz(
      QuizModel quiz) async {

    return await _service.createFullQuiz(
      quiz,
    );

  }
  Future<QuizModel> getQuizDetail(
      int quizId,
      ) async {

    return await _service.getQuizDetail(
        quizId);

  }

  // Cập nhật Quiz
  Future<bool> updateQuiz(
      QuizModel quiz) async {

    return await _service.updateQuiz(
      quiz,
    );

  }

  // Xóa Quiz
  Future<bool> deleteQuiz(
      int quizId) async {

    return await _service.deleteQuiz(
      quizId,
    );

  }

}