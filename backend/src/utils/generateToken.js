const jwt = require("jsonwebtoken");
const env = require("../config/env");

const generateToken = (
    userId,
    username
) => {

    return jwt.sign(

        {
            id: userId,
            username: username
        },

        env.JWT_SECRET,

        {
            expiresIn: "7d"
        }
    );
};
console.log("JWT_SECRET =", env.JWT_SECRET);

module.exports = generateToken;