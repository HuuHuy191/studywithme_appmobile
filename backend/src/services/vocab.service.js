const Vocab = require("../models/vocab.model");
const Course = require("../models/course.model");

// Tạo vocab
const createVocab = async (
    userId,
    data
) => {

    const course = await Course.findOne({
        where: {
            id: data.courseId,
            userId: userId
        }
    });

    if (!course) {
        throw new Error(
            "You do not own this course"
        );
    }

    return await Vocab.create(data);
};

// Lấy danh sách vocab theo course
const getVocabsByCourse = async (
    userId,
    courseId
) => {

    const course = await Course.findOne({
        where: {
            id: courseId,
            userId: userId
        }
    });

    if (!course) {
        throw new Error(
            "Access denied"
        );
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
            userId: userId
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

module.exports = {
    createVocab,
    getVocabsByCourse,
    deleteVocab
};