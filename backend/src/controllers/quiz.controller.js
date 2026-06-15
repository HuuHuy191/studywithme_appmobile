const quizService =
require("../services/quiz.service");

// Tạo quiz
exports.createQuiz = async (
    req,
    res
) => {

    try {

        const quiz =
        await quizService.createQuiz(
            req.user.id,
            req.body
        );

        res.status(201).json({
            success: true,
            data: quiz
        });

    } catch (error) {

        res.status(403).json({
            success: false,
            message: error.message
        });

    }

};

// Lấy danh sách quiz
exports.getQuizzes = async (
    req,
    res
) => {

    try {

        const quizzes =
        await quizService.getQuizzesByCourse(
            req.user.id,
            req.params.courseId
        );

        res.json({
            success: true,
            data: quizzes
        });

    } catch (error) {

        res.status(403).json({
            success: false,
            message: error.message
        });

    }

};

// Xóa quiz
exports.deleteQuiz = async (
    req,
    res
) => {

    try {

        await quizService.deleteQuiz(
            req.user.id,
            req.params.id
        );

        res.json({
            success: true,
            message:
            "Deleted successfully"
        });

    } catch (error) {

        res.status(403).json({
            success: false,
            message: error.message
        });

    }

};