const Quiz = require("../models/quiz.model");
const Course = require("../models/course.model");
const QuizResult = require("../models/quizResult.model");
const ClassMember = require("../models/classMember.model");
const sequelize = require("../config/db");
const QuizQuestion = require("../models/quizQuestion.model");
// Hàm tạo quiz
const createQuiz = async (userId, data) => {

    const course = await Course.findOne({
        where: {
            id: data.courseId,
            ownerId: userId
        }
    });

    if (!course) {
        throw new Error("You do not own this course");
    }

    return await Quiz.create({

        title: data.title,

        description: data.description,

        courseId: data.courseId,

        createdBy: userId

    });

};
const createFullQuiz = async (
    userId,
    data
) => {

    const transaction =
        await sequelize.transaction();

    try {

const course = await Course.findOne({
    where: {
        id: data.courseId,
        ownerId: userId
    }
});

if (!course) {
    throw new Error("You do not own this course");
}
const quiz = await Quiz.create(

    {

        title: data.title,

        description: data.description,

        courseId: data.courseId,

        createdBy: userId

    },

    {

        transaction

    }

);
for (const item of data.questions) {

    await QuizQuestion.create(

        {

            quizId: quiz.id,

            question: item.question,

            optionA: item.optionA,

            optionB: item.optionB,

            optionC: item.optionC,

            optionD: item.optionD,

            correctAnswer: item.correctAnswer

        },

        {

            transaction

        }

    );

}
await transaction.commit();

return quiz;
    } catch (error) {

        await transaction.rollback();

        throw error;

    }

};
//Hàm lấy danh sách quiz
const getQuizzesByCourse = async (
    userId,
    courseId
) => {

    const owner = await Course.findOne({
        where: {
            id: courseId,
            ownerId: userId
        }
    });

    const member = await ClassMember.findOne({
        where: {
            classroomId: courseId,
            userId
        }
    });

    if (!owner && !member) {
        throw new Error("Access denied");
    }

    return await Quiz.findAll({

        where: {
            courseId
        },

        order: [
            ["createdAt", "ASC"]
        ]

    });

};
const getQuizDetail = async (
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

    const questions =
        await QuizQuestion.findAll({

            where: {
                quizId
            },

            order: [
                ["id", "ASC"]
            ]

        });

    return {

        ...quiz.toJSON(),

        questions

    };

};
// lấy các quiz từ các lớp
const getMyQuizzes = async (userId) => {

    // 1. Lấy tất cả lớp mà user là chủ
    const ownerCourses = await Course.findAll({
        where: {
            ownerId: userId
        }
    });

    // 2. Lấy tất cả lớp mà user là thành viên
    const members = await ClassMember.findAll({
        where: {
            userId
        }
    });

    // 3. Gộp tất cả courseId
    const courseIds = new Set();

    ownerCourses.forEach(c => courseIds.add(c.id));

    members.forEach(m => courseIds.add(m.classroomId));

    // 4. Kết quả trả về
    const result = [];

    for (const courseId of courseIds) {

        const course = await Course.findByPk(courseId);

        if (!course) continue;

        const quizzes = await Quiz.findAll({

            where: {
                courseId
            },

            order: [
                ["createdAt", "ASC"]
            ]

        });

        result.push({

            courseId: course.id,

            courseName: course.name,

            owner: course.ownerId === userId,

            quizzes

        });

    }

    return result;

};
//Hàm xóa
const deleteQuiz = async (
    userId,
    quizId
) => {

    const quiz = await Quiz.findByPk(quizId);

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

    await quiz.destroy();

    return true;

};
//Hàm sửa
const updateQuiz = async (
    userId,
    quizId,
    data
) => {

    const transaction =
        await sequelize.transaction();

    try {

        const quiz = await Quiz.findByPk(quizId);

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

        await quiz.update(

            {

                title: data.title,

                description: data.description

            },

            {

                transaction

            }

        );

        // Xóa toàn bộ câu hỏi cũ
        await QuizQuestion.destroy({

            where: {
                quizId
            },

            transaction

        });

        // Thêm lại toàn bộ câu hỏi
        for (const item of data.questions) {

            await QuizQuestion.create(

                {

                    quizId,

                    question: item.question,

                    optionA: item.optionA,

                    optionB: item.optionB,

                    optionC: item.optionC,

                    optionD: item.optionD,

                    correctAnswer: item.correctAnswer

                },

                {

                    transaction

                }

            );

        }

        await transaction.commit();

        return quiz;

    } catch (error) {

        await transaction.rollback();

        throw error;

    }

};
module.exports = {

    createQuiz,

    createFullQuiz,

    getQuizzesByCourse,

    updateQuiz,

    deleteQuiz,
    getMyQuizzes,
    getQuizDetail,

};