const { DataTypes } = require("sequelize");
const sequelize = require("../config/db");

const Vocab = sequelize.define(
  "Vocab",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },

    word: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },

    meaning: {
      type: DataTypes.TEXT,
      allowNull: false,
    },

    example: {
      type: DataTypes.TEXT,
      allowNull: true,
    },

    courseId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    tableName: "Vocabs",
    timestamps: true,
  }
);

module.exports = Vocab;