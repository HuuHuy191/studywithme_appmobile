const { DataTypes } = require("sequelize");
const sequelize = require("../config/db");

const Classroom = sequelize.define(
  "Classroom",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },

    name: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },

    description: {
      type: DataTypes.TEXT,
      allowNull: true,
    },

    classCode: {
      type: DataTypes.STRING(10),
      allowNull: false,
      unique: true,
    },

    ownerId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },

    // Thêm mới
    maxMembers: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 30,
    },
  },
  {
    tableName: "Classrooms",
    timestamps: true,
  }
);

module.exports = Classroom;