const bcrypt = require("bcryptjs");
const User = require("../models/user.model");
const generateToken = require("../utils/generateToken");

const register = async (username, email, password) => {
   console.log("username =", username);
    console.log("email =", email);
    console.log("password =", password);
    const existingUser = await User.findOne({
        where: { email }
    });

    if (existingUser) {
        throw new Error("Email already exists");
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await User.create({
        username,
        email,
        password: hashedPassword
    });

    return {
        id: user.id,
        username: user.username,
        email: user.email,
        token: generateToken(
            user.id,
            user.username
        )
    };
};

const login = async (email, password) => {

    const user = await User.findOne({
        where: { email }
    });

    if (!user) {
        throw new Error("Invalid email");
    }

    const isMatch = await bcrypt.compare(
        password,
        user.password
    );

    if (!isMatch) {
        throw new Error("Invalid password");
    }

    return {
        id: user.id,
        username: user.username,
        email: user.email,
        token: generateToken(
            user.id,
            user.username
        )
    };
};

module.exports = {
    register,
    login
};