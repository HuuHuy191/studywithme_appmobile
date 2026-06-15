const Quiz = require("../models/quiz.model");
const Course = require("../models/course.model");

// Tạo câu hỏi
const createQuiz = async (
    userId,
    data
) => {

    const course =
    await Course.findOne({
        where: {
            id: data.courseId,
            userId
        }
    });

    if (!course) {
        throw new Error(
            "You do not own this course"
        );
    }

    return await Quiz.create(data);
};

// Lấy danh sách câu hỏi
const getQuizzesByCourse =
async (
    userId,
    courseId
) => {

    const course =
    await Course.findOne({
        where: {
            id: courseId,
            userId
        }
    });

    if (!course) {
        throw new Error(
            "Access denied"
        );
    }

    return await Quiz.findAll({
        where: {
            courseId
        }
    });
};

// Xóa câu hỏi
const deleteQuiz = async (
    userId,
    quizId
) => {

    const quiz =
    await Quiz.findByPk(quizId);

    if (!quiz) {
        throw new Error(
            "Quiz not found"
        );
    }

    const course =
    await Course.findOne({
        where: {
            id: quiz.courseId,
            userId
        }
    });

    if (!course) {
        throw new Error(
            "Access denied"
        );
    }

    await quiz.destroy();

    return true;
};

module.exports = {
    createQuiz,
    getQuizzesByCourse,
    deleteQuiz
};