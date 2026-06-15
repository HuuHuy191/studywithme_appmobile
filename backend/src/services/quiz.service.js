const Quiz = require("../models/quiz.model");
const Course = require("../models/course.model");
const QuizResult = require("../models/quizResult.model");

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

const submitQuiz = async (
    userId,
    courseId,
    answers
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

    const questions =
    await Quiz.findAll({
        where: {
            courseId
        }
    });

    let correctAnswers = 0;

    for (const answer of answers) {

        const question =
        questions.find(
            q => q.id === answer.questionId
        );

        if (
            question &&
            question.correctAnswer === answer.answer
        ) {
            correctAnswers++;
        }
    }

    const score =
    Math.round(
        (correctAnswers /
         questions.length) * 100
    );

    const result =
    await QuizResult.create({

        score,

        totalQuestions:
            questions.length,

        correctAnswers,

        userId,

        courseId

    });

    return result;
};

const getResults = async (
    userId,
    courseId
) => {

    return await QuizResult.findAll({

        where: {
            userId,
            courseId
        },

        order: [
            ["createdAt", "DESC"]
        ]

    });

};
module.exports = {
    createQuiz,
    getQuizzesByCourse,
    deleteQuiz,
    submitQuiz,
    getResults
};