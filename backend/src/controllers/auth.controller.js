const authService = require("../services/auth.service");

const register = async (req, res) => {
    try {

        console.log("BODY:", req.body);

        const { username, email, password } = req.body;

        const result = await authService.register(
            username,
            email,
            password
        );

        res.status(201).json({
            success: true,
            data: result
        });

    } catch (error) {

        console.error("REGISTER ERROR:");
        console.error(error);

        res.status(400).json({
            success: false,
            message: error.message,
            stack: error.stack
        });
    }
};
const login = async (req, res) => {
    try {

        const { email, password } = req.body;

        const result = await authService.login(
            email,
            password
        );

        res.json({
            success: true,
            data: result
        });

    } catch (error) {

        res.status(400).json({
            success: false,
            message: error.message
        });
    }
};

module.exports = {
    register,
    login
};