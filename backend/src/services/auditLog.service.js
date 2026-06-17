const AuditLog =
require("../models/auditLog.model");

const saveLog = async (
    user,
    action,
    description
) => {

    await AuditLog.create({

        userId: user.id,

        username:
        user.username,

        action,

        description
    });
};

module.exports = {
    saveLog
};