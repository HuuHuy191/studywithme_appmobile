const quizService = require("../services/quiz.service");

// Tạo Quiz
exports.createQuiz = async (req, res) => {

    try {

        const quiz = await quizService.createQuiz(
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
// Tạo quiz + danh sách câu hỏi
exports.createFullQuiz = async (
    req,
    res
) => {

    try {

        const quiz =
        await quizService.createFullQuiz(

            req.user.id,

            req.body

        );

        res.status(201).json({

            success: true,

            data: quiz

        });

    } catch (error) {

        console.error(error);

        res.status(400).json({

            success: false,

            message: error.message

        });

    }

};
exports.getQuizDetail = async (
    req,
    res
) => {

    try {

        const quiz =
        await quizService.getQuizDetail(

            req.user.id,

            req.params.id

        );

        return res.json({

            success: true,

            data: quiz

        });

    } catch (err) {

        return res.status(403).json({

            success: false,

            message: err.message

        });

    }

};
// Lấy danh sách Quiz
exports.getQuizzes = async (req, res) => {

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
//lấy các quiz từ ccs lớp
exports.getMyQuizzes = async (req, res) => {

    try {

        const data =
        await quizService.getMyQuizzes(
            req.user.id
        );

        return res.status(200).json({

            success: true,

            data

        });

    } catch (err) {

        console.error(err);

        return res.status(500).json({

            success: false,

            message: err.message

        });

    }

};
// Cập nhật Quiz
exports.updateQuiz = async (req, res) => {

    try {

        const quiz =
        await quizService.updateQuiz(

            req.user.id,

            req.params.id,

            req.body

        );

        res.json({

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

// Xóa Quiz
exports.deleteQuiz = async (req, res) => {

    try {

        await quizService.deleteQuiz(

            req.user.id,

            req.params.id

        );

        res.json({

            success: true,

            message: "Deleted successfully"

        });

    } catch (error) {

        res.status(403).json({

            success: false,

            message: error.message

        });

    }

};