const { DataTypes } = require("sequelize");
const sequelize = require("../config/db");

const QuizQuestion = sequelize.define(
  "QuizQuestion",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },

    quizId: {
      type: DataTypes.INTEGER,
      allowNull: false,
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
  },
  {
    tableName: "QuizQuestions",
    timestamps: true,
  }
);

module.exports = QuizQuestion;