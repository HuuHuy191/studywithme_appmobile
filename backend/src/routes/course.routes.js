const express = require("express");
const router = express.Router();

const courseController =
require("../controllers/course.controller");

const authMiddleware =
require("../middlewares/authMiddleware");

// Danh sách lớp
router.get(
    "/",
    authMiddleware,
    courseController.getCourses
);

// Chi tiết đầy đủ của lớp
router.get(
    "/:id/detail",
    authMiddleware,
    courseController.getClassDetail
);

// Lấy thông tin cơ bản của lớp
router.get(
    "/:id",
    authMiddleware,
    courseController.getCourseById
);

// Tạo lớp
router.post(
    "/",
    authMiddleware,
    courseController.createCourse
);

// Tham gia lớp
router.post(
    "/join",
    authMiddleware,
    courseController.joinClass
);
//chỉnh sửa thông tin lớp
router.put(
    "/:id",
    authMiddleware,
    courseController.updateCourse
);
// Chủ lớp xóa thành viên
router.delete(
    "/:courseId/member/:userId",
    authMiddleware,
    courseController.removeMember
);
// Xóa lớp
router.delete(
    "/:id",
    authMiddleware,
    courseController.deleteCourse
);

module.exports = router;