const jwt = require("jsonwebtoken");


const authMiddleware = async (
  req,
  res,
  next
) => {
  try {

    const authHeader =
      req.headers.authorization;
    //kiểm tra xem có token không
    if (!authHeader) {
      return res.status(401).json({
        success: false,
        message: "No token provided",
      });
    }


    const token = authHeader.split(" ")[1];

//check format oken
    if (!token) {
      return res.status(401).json({
        success: false,
        message: "Invalid token format",
      });
    }

   //Giải mã token
    const decoded = jwt.verify(
      token,
      process.env.JWT_SECRET
    );

    req.user = decoded;

    next();

  } catch (error) {

 //token sai hoặc hết hạn
    return res.status(401).json({
      success: false,
      message: "Unauthorized",
      error: error.message,
    });

  }
};

module.exports = authMiddleware;