const courseService =
require("../services/course.service");

// Lấy tất cả course của user
exports.getCourses = async (req, res) => {

    try {

        const courses =
        await courseService.getCourses(
            req.user.id
        );

        res.json({
            success: true,
            data: courses
        });

    } catch (error) {

        res.status(500).json({
            success: false,
            message: error.message
        });

    }
};

// Lấy course theo id
exports.getCourseById = async (req, res) => {

    try {

        const course =
        await courseService.getCourseById(
            req.user.id,
            req.params.id
        );

        res.json({
            success: true,
            data: course
        });

    } catch (error) {

        res.status(404).json({
            success: false,
            message: error.message
        });

    }
};

// Tạo course
exports.createCourse = async (req, res) => {

    try {

        const course =
        await courseService.createCourse(
            req.user.id,
            req.body
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

// Xóa course
exports.deleteCourse = async (req, res) => {

    try {

        await courseService.deleteCourse(
            req.user.id,
            req.params.id
        );

        res.json({
            success: true,
            message:
            "Course deleted successfully"
        });

    } catch (error) {

        res.status(404).json({
            success: false,
            message: error.message
        });

    }
};