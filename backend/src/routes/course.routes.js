const express = require("express");
const router = express.Router();

const courseController = require("../controllers/course.controller");
const authMiddleware = require("../middlewares/authMiddleware");

console.log("authMiddleware =", typeof authMiddleware);
console.log("getCourses =", typeof courseController.getCourses);
console.log("getCourseById =", typeof courseController.getCourseById);
console.log("createCourse =", typeof courseController.createCourse);
console.log("deleteCourse =", typeof courseController.deleteCourse);

router.get("/", authMiddleware, courseController.getCourses);

router.get("/:id", authMiddleware, courseController.getCourseById);

router.post("/", authMiddleware, courseController.createCourse);

router.delete("/:id", authMiddleware, courseController.deleteCourse);

module.exports = router;