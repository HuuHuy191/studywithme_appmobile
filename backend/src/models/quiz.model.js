const { DataTypes } = require("sequelize");
const sequelize = require("../config/db");

const Quiz = sequelize.define(
  "Quiz",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },

    question: {
      type: DataTypes.TEXT,
      allowNull: false,
    },

    optionA: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },

    optionB: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },

    optionC: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },

    optionD: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },

    correctAnswer: {
      type: DataTypes.ENUM("A", "B", "C", "D"),
      allowNull: false,
    },

    courseId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    tableName: "Quizzes",
    timestamps: true,
  }
);

module.exports = Quiz;