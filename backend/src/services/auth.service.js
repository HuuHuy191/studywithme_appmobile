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

    console.log("EMAIL =", email);
      console.log("PASSWORD =", password);
    const user = await User.findOne({
        where: { email }
    });

    console.log("LOCK UNTIL =", user.lock_until);
    console.log("TYPE =", typeof user.lock_until);

    if (user.lock_until) {
        console.log(
            "LOCK UNTIL ISO =",
            new Date(user.lock_until).toISOString()
        );
    }
      if (!user) {
            throw new Error("Invalid email");
        }
    console.log("ATTEMPTS =", user.login_attempts);
    console.log("LOCK UNTIL =", user.lock_until);


    // 1. KIỂM TRA TRẠNG THÁI KHÓA TÀI KHOẢN
    // Nếu có thời gian khóa và thời gian đó lớn hơn thời điểm hiện tại
    if (user.lock_until && user.lock_until > new Date()) {
        const remainingTime = Math.ceil((user.lock_until - new Date()) / 60000); // Đổi ra phút
        throw new Error(
           `Tài khoản đang bị khóa.
           Vui lòng thử lại sau ${remainingTime} phút.`
        );
    }

    const isMatch = await bcrypt.compare(
        password,
        user.password
    );

    // 2. XỬ LÝ KHI NHẬP SAI MẬT KHẨU
    if (!isMatch) {
        const newAttempts = user.login_attempts + 1;

        if (newAttempts >= 5) {
            // Sai đủ 5 lần: Tính thời gian khóa là 30 phút sau kể từ bây giờ
           const lockTime = new Date(
               Date.now() + 30 * 60 * 1000
           );
               console.log("===== LOCK ACCOUNT =====");
               console.log("NEW ATTEMPTS =", newAttempts);
               console.log("LOCK TIME =", lockTime);
            await user.update({
                login_attempts: newAttempts,
                  lock_until: lockTime
            });
             console.log("UPDATE SUCCESS");
          throw new Error(
            "Tài khoản đã bị khóa trong 30 phút do đăng nhập sai quá 5 lần."
          );
        } else {
            // Chưa đủ 5 lần: Chỉ tăng số lần sai thêm 1
            await user.update({ login_attempts: newAttempts });

            const attemptsLeft = 5 - newAttempts;
           throw new Error(
              `Sai mật khẩu. Bạn còn ${attemptsLeft} lần thử.`
           );
        }
    }

    // 3. ĐĂNG NHẬP THÀNH CÔNG: Reset số lần sai và thời gian khóa về ban đầu
    if (user.login_attempts > 0 || user.lock_until) {
        await user.update({
            login_attempts: 0,
            lock_until: null
        });
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