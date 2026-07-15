import '../models/vocab_model.dart';
import '../services/vocab_service.dart';

class VocabController {

  final VocabService _service =
  VocabService();

  // Lấy danh sách vocab của lớp
  Future<List<VocabModel>> getVocabs(
      int courseId) async {

    return await _service.getVocabs(
      courseId,
    );

  }

  // Thêm vocab
  Future<bool> createVocab({

    required String word,

    required String meaning,

    required String example,

    required int courseId,

  }) async {

    VocabModel vocab = VocabModel(

      word: word,

      meaning: meaning,

      example: example,

      courseId: courseId,

    );

    return await _service.createVocab(
      vocab,
    );

  }

  // Cập nhật vocab
  Future<bool> updateVocab({

    required int id,

    required String word,

    required String meaning,

    required String example,

    required int courseId,

  }) async {

    VocabModel vocab = VocabModel(

      id: id,

      word: word,

      meaning: meaning,

      example: example,

      courseId: courseId,

    );

    return await _service.updateVocab(
      vocab,
    );

  }

  // Xóa vocab
  Future<bool> deleteVocab(
      int vocabId) async {

    return await _service.deleteVocab(
      vocabId,
    );

  }

}