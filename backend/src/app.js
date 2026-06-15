const express = require("express");
const cors = require("cors");


const authRoutes = require("./routes/auth.routes");
const courseRoutes = require("./routes/course.routes");
const vocabRoutes = require("./routes/vocab.routes");
const quizRoutes = require("./routes/quiz.routes");

const app = express();

app.use(cors());

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.get("/api/test", (req, res) => {
    res.json({
        message: "Backend connected successfully"
    });
});
app.use("/api/auth", authRoutes);
app.use("/api/courses", courseRoutes);
app.use("/api/vocab", vocabRoutes);
app.use("/api/quiz", quizRoutes);


module.exports = app;
