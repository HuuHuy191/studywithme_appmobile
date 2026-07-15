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

    title: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },

    description: {
      type: DataTypes.TEXT,
      allowNull: true,
    },

    courseId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },

    createdBy: {
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