const Course = require("../models/course.model");

// Sinh mã lớp ngẫu nhiên
function generateClassCode() {
    return Math.random()
        .toString(36)
        .substring(2, 8)
        .toUpperCase();
}

// Tạo lớp học
const createCourse = async (
    userId,
    data
) => {

    return await Course.create({

        name: data.name,

        description:
        data.description,

        classCode:
        generateClassCode(),

        ownerId: userId

    });

};

// Lấy danh sách lớp do mình tạo
const getCourses = async (
    userId
) => {

    return await Course.findAll({

        where: {
            ownerId: userId
        }

    });

};

// Lấy chi tiết lớp
const getCourseById = async (
    userId,
    courseId
) => {

    const course =
    await Course.findOne({

        where: {
            id: courseId,
            ownerId: userId
        }

    });

    if (!course) {

        throw new Error(
            "Class not found"
        );

    }

    return course;
};

// Xóa lớp
const deleteCourse = async (
    userId,
    courseId
) => {

    const course =
    await Course.findOne({

        where: {
            id: courseId,
            ownerId: userId
        }

    });

    if (!course) {

        throw new Error(
            "Class not found"
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