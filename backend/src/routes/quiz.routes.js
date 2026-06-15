const express = require("express");
const router = express.Router();

const quizController =
require("../controllers/quiz.controller");

const authMiddleware =
require("../middlewares/authMiddleware");

// Tạo câu hỏi
router.post(
    "/",
    authMiddleware,
    quizController.createQuiz
);

// Lấy câu hỏi theo course
router.get(
    "/course/:courseId",
    authMiddleware,
    quizController.getQuizzes
);

// Xóa câu hỏi
router.delete(
    "/:id",
    authMiddleware,
    quizController.deleteQuiz
);

router.post(
    "/submit",
    authMiddleware,
    quizController.submitQuiz
);
router.get(
    "/results/:courseId",
    authMiddleware,
    quizController.getResults
);
module.exports = router;