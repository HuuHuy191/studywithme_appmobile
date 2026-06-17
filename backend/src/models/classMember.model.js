const { DataTypes } = require("sequelize");
const sequelize = require("../config/db");

const ClassMember = sequelize.define(
  "ClassMember",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },

    classroomId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },

    userId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },

    role: {
      type: DataTypes.ENUM(
        "owner",
        "member"
      ),
      defaultValue: "member",
    },
  },
  {
    tableName: "ClassMembers",
    timestamps: true,
  }
);

module.exports = ClassMember;