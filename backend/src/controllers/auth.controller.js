const authService = require("../services/auth.service");
const {
    saveLog
} = require(
    "../services/auditLog.service"
);
const register = async (req, res) => {
    try {

        console.log("BODY:", req.body);

        const { username, email, password } = req.body;

        const result = await authService.register(
            username,
            email,
            password
        );
        await saveLog(
            result,
            "REGISTER",
            "Đăng ký tài khoản mới"
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
        await saveLog(
            result,
            "LOGIN",
            "Đăng nhập thành công"
        );


        res.json({
            success: true,
            data: result
        });

    } catch (error) {
           console.log("LOGIN ERROR:");
            console.log(error);
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