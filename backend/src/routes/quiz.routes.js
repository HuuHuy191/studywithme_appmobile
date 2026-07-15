const express = require("express");

const router = express.Router();

const authMiddleware =
require("../middlewares/authMiddleware");

const quizController =
require("../controllers/quiz.controller");

router.post(

    "/full",

    authMiddleware,

    quizController.createFullQuiz

);
// Tạo Quiz
router.post(

    "/",

    authMiddleware,

    quizController.createQuiz

);
router.get(

    "/my",

    authMiddleware,

    quizController.getMyQuizzes

);
// Danh sách Quiz của lớp
router.get(

    "/course/:courseId",

    authMiddleware,

    quizController.getQuizzes

);
router.get(

    "/:id",

    authMiddleware,

    quizController.getQuizDetail

);
// Cập nhật Quiz
router.put(

    "/:id",

    authMiddleware,

    quizController.updateQuiz

);

// Xóa Quiz
router.delete(

    "/:id",

    authMiddleware,

    quizController.deleteQuiz

);

module.exports = router;