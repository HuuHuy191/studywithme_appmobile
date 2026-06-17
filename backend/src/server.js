const app = require("./app");

const sequelize = require("./config/db");
const env = require("./config/env");
const { QueryTypes } = require("sequelize");

// IMPORT MODELS
require("./models/user.model");
require("./models/course.model");
require("./models/auditLog.model");

async function startServer() {
    try {

        await sequelize.authenticate();
        console.log(" SQL Server connected");

        await sequelize.sync();
        console.log("Database synchronized");

        const otps = await sequelize.query(
            "SELECT * FROM OTPs",
            {
                type: QueryTypes.SELECT
            }
        );

        if (otps.length === 0) {
            console.log("⚠️ Bảng OTPs đang trống");
        } else {
            console.log(`✅ Có ${otps.length} bản ghi`);
            console.table(otps);
        }

        app.listen(env.PORT, () => {
            console.log(
                `🚀 Server running on port ${env.PORT}`
            );
        });

    } catch (err) {

        console.error("Startup failed:");
        console.error(err);

    }
}

startServer();