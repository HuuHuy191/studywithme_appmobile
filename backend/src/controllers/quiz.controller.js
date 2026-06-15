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
exports.submitQuiz = async (req, res) => {

    try {

        const result =
        await quizService.submitQuiz(

            req.user.id,

            req.body.courseId,

            req.body.answers

        );

        res.json({
            success: true,
            data: result
        });

    } catch (error) {

        res.status(400).json({
            success: false,
            message: error.message
        });

    }

};
exports.getResults =
async (req, res) => {

    const results =
    await quizService.getResults(

        req.user.id,

        req.params.courseId

    );

    res.json({
        success: true,
        data: results
    });

};