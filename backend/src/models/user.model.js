const { DataTypes } = require("sequelize");
const sequelize = require("../config/db");

const User = sequelize.define(
    "User",
    {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },

        username: {
            type: DataTypes.STRING,
            allowNull: false
        },

        email: {
            type: DataTypes.STRING,
            unique: true,
            allowNull: false
        },

        password: {
            type: DataTypes.STRING,
            allowNull: false
        },

        avatar: {
            type: DataTypes.STRING
        },

        role: {
            type: DataTypes.STRING
        },
        login_attempts: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    defaultValue: 0 // Mặc định ban đầu là 0 lần sai
                },

                lock_until: {
                    type: DataTypes.DATE,
                    allowNull: true // Bình thường sẽ là null, chỉ có giá trị khi bị khóa
                },


                created_at: {
                    type: DataTypes.DATE
                },

        created_at: {
            type: DataTypes.DATE
        }
    },
    {
        timestamps: false
    }
);

module.exports = User;