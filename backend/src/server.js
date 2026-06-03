const app = require("./app");

const sequelize = require("./config/db");
const env = require("./config/env");
const { QueryTypes } = require("sequelize");
async function startServer() {
    try {
        // Test kết nối
        await sequelize.authenticate();
        console.log(" SQL Server connected");

        // Đồng bộ model
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
        // Khởi động server
        app.listen(env.PORT, () => {
            console.log(`🚀 Server running on port ${env.PORT}`);
        });

    } catch (err) {
        console.error(" Startup failed:");
        console.error(err);
    }
}

startServer();