const Course = require("../models/course.model");

// Tạo Course
const createCourse = async (
    userId,
    data
) => {

    return await Course.create({
        title: data.title,
        description: data.description,
        type: data.type,
        userId: userId
    });

};

// Lấy tất cả Course của User
const getCourses = async (
    userId
) => {

    return await Course.findAll({
        where: {
            userId: userId
        }
    });

};

// Lấy Course theo ID
const getCourseById = async (
    userId,
    courseId
) => {

    const course =
    await Course.findOne({
        where: {
            id: courseId,
            userId: userId
        }
    });

    if (!course) {
        throw new Error(
            "Course not found"
        );
    }

    return course;
};

// Xóa Course
const deleteCourse = async (
    userId,
    courseId
) => {

    const course =
    await Course.findOne({
        where: {
            id: courseId,
            userId: userId
        }
    });

    if (!course) {
        throw new Error(
            "Course not found"
        );
    }

    await course.destroy();

    return true;
};

module.exports = {
    createCourse,
    getCourses,
    getCourseById,
    deleteCourse
};