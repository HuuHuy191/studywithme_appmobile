const Vocab = require("../models/vocab.model");
const Course = require("../models/course.model");
const ClassMember = require("../models/classMember.model");

// Tạo vocab
const createVocab = async (
    userId,
    data
) => {

    const course = await Course.findOne({
        where: {
            id: data.courseId,
            ownerId: userId
        }
    });

    if (!course) {
        throw new Error(
            "You do not own this course"
        );
    }

    return await Vocab.create({

        word: data.word,

        meaning: data.meaning,

        example: data.example,

        courseId: data.courseId,

        createdBy: userId

    });
};

// Lấy danh sách vocab theo course
const getVocabsByCourse = async (
    userId,
    courseId
) => {

    // Nếu là chủ lớp thì được xem
    const owner = await Course.findOne({
        where: {
            id: courseId,
            ownerId: userId
        }
    });

    if (owner) {
        return await Vocab.findAll({
            where: {
                courseId
            }
        });
    }

    // Nếu là thành viên thì cũng được xem
    const member = await ClassMember.findOne({
        where: {
            classroomId: courseId,
            userId: userId
        }
    });

    if (!member) {
        throw new Error("Access denied");
    }

    return await Vocab.findAll({
        where: {
            courseId
        }
    });

};
// Xóa vocab
const deleteVocab = async (
    userId,
    vocabId
) => {

    const vocab = await Vocab.findByPk(
        vocabId
    );

    if (!vocab) {
        throw new Error(
            "Vocab not found"
        );
    }

    const course = await Course.findOne({
        where: {
            id: vocab.courseId,
            ownerId: userId
        }
    });

    if (!course) {
        throw new Error(
            "Access denied"
        );
    }

    await vocab.destroy();

    return true;
};
const updateVocab = async (
    userId,
    vocabId,
    data
) => {

    const vocab = await Vocab.findByPk(vocabId);

    if (!vocab) {
        throw new Error("Vocabulary not found");
    }

    const course = await Course.findOne({
        where: {
            id: vocab.courseId,
            ownerId: userId
        }
    });

    if (!course) {
        throw new Error("Access denied");
    }

    await vocab.update({

        word: data.word,

        meaning: data.meaning,

        example: data.example

    });

    return vocab;
};
module.exports = {
    createVocab,
    getVocabsByCourse,
    deleteVocab,
    updateVocab
};