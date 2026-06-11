const User = require("./user.model");
const Course = require("./course.models");
const Vocab = require("./vocab.model");
const Quiz = require("./quiz.model");

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

module.exports = {
  User,
  Course,
  Vocab,
  Quiz,
};