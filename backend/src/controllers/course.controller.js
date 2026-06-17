const courseService =
require("../services/course.service");
const {
    saveLog
} = require(
    "../services/auditLog.service"
);
// Lấy tất cả lớp học của user
exports.getCourses = async (req, res) => {

    try {

        const classes =
        await courseService.getCourses(
            req.user.id
        );

        res.json({
            success: true,
            data: classes
        });

    } catch (error) {

        res.status(500).json({
            success: false,
            message: error.message
        });

    }
};

// Lấy chi tiết lớp học
exports.getCourseById = async (req, res) => {

    try {

        const classroom =
        await courseService.getCourseById(
            req.user.id,
            req.params.id
        );

        res.json({
            success: true,
            data: classroom
        });

    } catch (error) {

        res.status(404).json({
            success: false,
            message: error.message
        });

    }
};

// Tạo lớp học
exports.createCourse = async (req, res) => {

    try {

        const course =
        await courseService.createCourse(
            req.user.id,
            req.body
        );

        await saveLog(

            req.user,

            "CREATE_CLASS",

            `Tạo lớp ${course.name}`

        );

        res.status(201).json({
            success: true,
            data: course
        });

    } catch (error) {

        res.status(500).json({
            success: false,
            message: error.message
        });

    }
};

// Xóa lớp học
exports.deleteCourse = async (req, res) => {

    try {

        await courseService.deleteCourse(
            req.user.id,
            req.params.id
        );

        res.json({
            success: true,
            message:
            "Class deleted successfully"
        });

    } catch (error) {

        res.status(404).json({
            success: false,
            message: error.message
        });

    }
};