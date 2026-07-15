const app = require("./app");

const sequelize = require("./config/db");
const env = require("./config/env");
const { QueryTypes } = require("sequelize");

// IMPORT MODELS
const User = require("./models/user.model");
const Course = require("./models/course.model");
const ClassMember = require("./models/classMember.model");
const AuditLog = require("./models/auditLog.model");
const Quiz = require("./models/quiz.model");
const QuizQuestion = require("./models/quizQuestion.model");
// Một lớp có nhiều thành viên
Course.hasMany(ClassMember, {
    foreignKey: "classroomId"
});

// Một thành viên thuộc một lớp
ClassMember.belongsTo(Course, {
    foreignKey: "classroomId"
});

User.hasMany(ClassMember,{
    foreignKey:"userId"
});

ClassMember.belongsTo(User,{
    foreignKey:"userId"
});

Course.hasMany(Quiz,{
    foreignKey:"courseId"
});

Quiz.belongsTo(Course,{
    foreignKey:"courseId"
});
Quiz.hasMany(QuizQuestion, {
    foreignKey: "quizId",
    onDelete: "CASCADE",
    hooks: true
});

QuizQuestion.belongsTo(Quiz, {
    foreignKey: "quizId"
});
async function startServer() {
    try {

        await sequelize.authenticate();
        console.log(" SQL Server connected");

        await sequelize.sync();
        console.log("Database synchronized");

        const otps = await sequelize.query(
            "SELECT * FROM OTPs",
            {
                type: QueryTypes.SELECT
            }
        );

        if (otps.length === 0) {
            console.log("⚠️ Bảng OTPs đang trống");
        } else {
            console.log(`✅ Có ${otps.length} bản ghi`);
            console.table(otps);
        }

        app.listen(env.PORT, () => {
            console.log(
                `🚀 Server running on port ${env.PORT}`
            );
        });

    } catch (err) {

        console.error("Startup failed:");
        console.error(err);

    }
}

startServer();