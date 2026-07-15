const User = require("./user.model");
const Course = require("./course.model");
const Vocab = require("./vocab.model");
const Quiz = require("./quiz.model");
const ClassMember = require("./classMember.model");

// User - Course
User.hasMany(Course, {
  foreignKey: "userId",
});

Course.belongsTo(User, {
  foreignKey: "userId",
});

// Course - Vocab
Course.hasMany(Vocab, {
  foreignKey: "courseId",
});

Vocab.belongsTo(Course, {
  foreignKey: "courseId",
});

// Course - Quiz
Course.hasMany(Quiz, {
  foreignKey: "courseId",
});

Quiz.belongsTo(Course, {
  foreignKey: "courseId",
});

// Course - ClassMember
Course.hasMany(ClassMember, {
    foreignKey: "classroomId"
});

ClassMember.belongsTo(Course, {
    foreignKey: "classroomId"
});

// User - ClassMember
User.hasMany(ClassMember, {
    foreignKey: "userId"
});

ClassMember.belongsTo(User, {
    foreignKey: "userId"
});
module.exports = {
  User,
  Course,
  Vocab,
  Quiz,
  ClassMember
};