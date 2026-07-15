const Course = require("../models/course.model");
const ClassMember = require("../models/classMember.model");
const User = require("../models/user.model");
// Sinh mã lớp ngẫu nhiên
function generateClassCode() {
    return Math.random()
        .toString(36)
        .substring(2, 8)
        .toUpperCase();
}

// Tạo lớp học
const createCourse = async (
    userId,
    data
) => {

    // Tạo lớp học
    const course = await Course.create({

        name: data.name,

        description: data.description,

        classCode: generateClassCode(),

        ownerId: userId,

        maxMembers: data.maxMembers

    });

    // Thêm chủ lớp vào danh sách thành viên
    await ClassMember.create({

        classroomId: course.id,

        userId: userId,

        role: "owner"

    });

    return course;
};

// Lấy danh sách lớp do mình tạo
const getCourses = async (
    userId
) => {

    return await Course.findAll({

        where: {
            ownerId: userId
        }

    });

};

const getClassDetail = async (classId) => {

    // Lấy thông tin lớp
    const classroom = await Course.findByPk(classId);

    if (!classroom) {
        throw new Error("Không tìm thấy lớp.");
    }

    // Lấy danh sách thành viên
    const members = await ClassMember.findAll({

        where: {
            classroomId: classId
        },

        include: [
            {
                model: User,
                attributes: [
                    "id",
                    "email"
                ]
            }
        ]

    });

    return {

        ...classroom.toJSON(),

        memberCount: members.length,

        members

    };

};
// Lấy chi tiết lớp
const getCourseById = async (
    userId,
    courseId
) => {

    const course =
    await Course.findOne({

        where: {
            id: courseId,
            ownerId: userId
        }

    });

    if (!course) {

        throw new Error(
            "Class not found"
        );

    }

    return course;
};

// Tham gia lớp học
const joinClass = async (userId, classCode) => {

    console.log("========== JOIN CLASS ==========");
    console.log("USER ID =", userId);
    console.log("CLASS CODE =", classCode);

    const course = await Course.findOne({
        where: {
            classCode: classCode
        }
    });

    console.log("COURSE =", course);

    if (!course) {
        throw new Error("Không tìm thấy lớp học.");
    }

    const joined = await ClassMember.findOne({
        where: {
            classroomId: course.id,
            userId: userId
        }
    });

    console.log("JOINED =", joined);

    const totalMembers = await ClassMember.count({
        where: {
            classroomId: course.id
        }
    });

    console.log("TOTAL MEMBERS =", totalMembers);
    console.log("MAX MEMBERS =", course.maxMembers);

    if (joined) {
        throw new Error("Bạn đã tham gia lớp này.");
    }

    if (totalMembers >= course.maxMembers) {
        throw new Error("Lớp học đã đầy.");
    }

    await ClassMember.create({
        classroomId: course.id,
        userId: userId,
        role: "member"
    });

    console.log("JOIN SUCCESS");

    return course;
};
// Xóa lớp
const deleteCourse = async (
    userId,
    courseId
) => {

    const course =
    await Course.findOne({

        where: {
            id: courseId,
            ownerId: userId
        }

    });

    if (!course) {

        throw new Error(
            "Class not found"
        );

    }

    await course.destroy();

    return true;
};

const removeMember = async (
    ownerId,
    courseId,
    memberId
) => {

    // Kiểm tra người thực hiện có phải chủ lớp
    const course = await Course.findOne({

        where: {
            id: courseId,
            ownerId: ownerId
        }

    });

    if (!course) {
        throw new Error("Bạn không phải chủ lớp.");
    }

    // Không cho chủ lớp tự xóa mình
    if (Number(memberId) === Number(ownerId)) {
        throw new Error("Không thể xóa chủ lớp.");
    }

    const member = await ClassMember.findOne({

        where: {
            classroomId: courseId,
            userId: memberId
        }

    });

    if (!member) {
        throw new Error("Không tìm thấy thành viên.");
    }

    await member.destroy();

    return true;
};
// Chủ lớp sửa thông tin lớp
const updateCourse = async (
    userId,
    courseId,
    data
) => {

    const course = await Course.findOne({

        where: {
            id: courseId,
            ownerId: userId
        }

    });

    if (!course) {

        throw new Error("Không tìm thấy lớp học.");

    }

    await course.update({

        description: data.description,
        maxMembers: data.maxMembers

    });

    return course;
};
module.exports = {
    createCourse,
    getCourses,
    getCourseById,
    deleteCourse,
    joinClass,
    getClassDetail,
    updateCourse,
    removeMember
};