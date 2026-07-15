const quizQuestionService =
require("../services/quizQuestion.service");

// Thêm câu hỏi
exports.createQuestion = async (req, res) => {

    try {

        const question =
        await quizQuestionService.createQuestion(

            req.user.id,

            req.body

        );

        res.status(201).json({

            success: true,

            data: question

        });

    } catch (error) {

        res.status(403).json({

            success: false,

            message: error.message

        });

    }

};

// Danh sách câu hỏi
exports.getQuestions = async (req, res) => {

    try {

        const questions =
        await quizQuestionService.getQuestions(

            req.user.id,

            req.params.quizId

        );

        res.json({

            success: true,

            data: questions

        });

    } catch (error) {

        res.status(403).json({

            success: false,

            message: error.message

        });

    }

};

// Sửa câu hỏi
exports.updateQuestion = async (req, res) => {

    try {

        const question =
        await quizQuestionService.updateQuestion(

            req.user.id,

            req.params.id,

            req.body

        );

        res.json({

            success: true,

            data: question

        });

    } catch (error) {

        res.status(403).json({

            success: false,

            message: error.message

        });

    }

};

// Xóa câu hỏi
exports.deleteQuestion = async (req, res) => {

    try {

        await quizQuestionService.deleteQuestion(

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