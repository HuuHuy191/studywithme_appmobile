const express = require("express");
const cors = require("cors");


const authRoutes = require("./routes/auth.routes");

const app = express();

app.use(cors());

app.use(express.json());
app.get("/api/test", (req, res) => {
    res.json({
        message: "Backend connected successfully"
    });
});
app.use("/api/auth", authRoutes);

module.exports = app;
