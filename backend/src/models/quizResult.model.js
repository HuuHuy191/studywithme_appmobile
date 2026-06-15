const { DataTypes } = require("sequelize");
const sequelize = require("../config/db");

const QuizResult = sequelize.define(
  "QuizResult",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },

    score: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },

    totalQuestions: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },

    correctAnswers: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },

    userId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },

    courseId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    tableName: "QuizResults",
    timestamps: true,
  }
);

module.exports = QuizResult;