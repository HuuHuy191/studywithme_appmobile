const express = require("express");

const router = express.Router();

const authMiddleware =
require("../middlewares/authMiddleware");

const quizQuestionController =
require("../controllers/quizQuestion.controller");

// Thêm câu hỏi
router.post(

    "/",

    authMiddleware,

    quizQuestionController.createQuestion

);

// Danh sách câu hỏi của Quiz
router.get(

    "/quiz/:quizId",

    authMiddleware,

    quizQuestionController.getQuestions

);

// Cập nhật
router.put(

    "/:id",

    authMiddleware,

    quizQuestionController.updateQuestion

);

// Xóa
router.delete(

    "/:id",

    authMiddleware,

    quizQuestionController.deleteQuestion

);

module.exports = router;