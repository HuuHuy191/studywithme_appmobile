const QuizQuestion = require("../models/quizQuestion.model");
const Quiz = require("../models/quiz.model");
const Course = require("../models/course.model");
const ClassMember = require("../models/classMember.model");

const createQuestion = async (
    userId,
    data
) => {

    const quiz = await Quiz.findByPk(data.quizId);

    if (!quiz) {
        throw new Error("Quiz not found");
    }

    const course = await Course.findOne({
        where: {
            id: quiz.courseId,
            ownerId: userId
        }
    });

    if (!course) {
        throw new Error("Access denied");
    }

    return await QuizQuestion.create({

        quizId: data.quizId,

        question: data.question,

        optionA: data.optionA,

        optionB: data.optionB,

        optionC: data.optionC,

        optionD: data.optionD,

        correctAnswer: data.correctAnswer

    });

};

const getQuestions = async (
    userId,
    quizId
) => {

    const quiz = await Quiz.findByPk(quizId);

    if (!quiz) {
        throw new Error("Quiz not found");
    }

    const owner = await Course.findOne({

        where: {
            id: quiz.courseId,
            ownerId: userId
        }

    });

    const member = await ClassMember.findOne({

        where: {
            classroomId: quiz.courseId,
            userId
        }

    });

    if (!owner && !member) {
        throw new Error("Access denied");
    }

    return await QuizQuestion.findAll({

        where: {
            quizId
        },

        order: [
            ["createdAt", "ASC"]
        ]

    });

};

const updateQuestion = async (
    userId,
    questionId,
    data
) => {

    const question =
    await QuizQuestion.findByPk(questionId);

    if (!question) {
        throw new Error("Question not found");
    }

    const quiz =
    await Quiz.findByPk(question.quizId);

    const course =
    await Course.findOne({

        where: {
            id: quiz.courseId,
            ownerId: userId
        }

    });

    if (!course) {
        throw new Error("Access denied");
    }

    await question.update({

        question: data.question,

        optionA: data.optionA,

        optionB: data.optionB,

        optionC: data.optionC,

        optionD: data.optionD,

        correctAnswer: data.correctAnswer

    });

    return question;

};

const deleteQuestion = async (
    userId,
    questionId
) => {

    const question =
    await QuizQuestion.findByPk(questionId);

    if (!question) {
        throw new Error("Question not found");
    }

    const quiz =
    await Quiz.findByPk(question.quizId);

    const course =
    await Course.findOne({

        where: {
            id: quiz.courseId,
            ownerId: userId
        }

    });

    if (!course) {
        throw new Error("Access denied");
    }

    await question.destroy();

    return true;

};

module.exports = {

    createQuestion,

    getQuestions,

    updateQuestion,

    deleteQuestion

};