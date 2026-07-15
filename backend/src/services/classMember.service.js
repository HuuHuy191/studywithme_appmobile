const Course =
require("../models/course.model");

const ClassMember =
require("../models/classMember.model");

const sequelize =
require("../config/db");

const joinClass = async (
  userId,
  classCode
) => {

  const classroom =
  await Course.findOne({
    where: {
      classCode
    }
  });

  if (!classroom) {
    throw new Error(
      "Class not found"
    );
  }

  const existed =
  await ClassMember.findOne({
    where: {
      classroomId:
      classroom.id,
      userId
    }
  });

  if (existed) {
    throw new Error(
      "Already joined"
    );
  }

  return await ClassMember.create({
    classroomId:
    classroom.id,

    userId,

    role: "member"
  });
};

// Lấy danh sách lớp đã tham gia
const getJoinedClasses = async (userId) => {

    const classes = await ClassMember.findAll({

        where: {
            userId: userId
        },

       include: [
           {
               model: Course,
               required: true
           }
       ]

    });

    return classes;
};

const User =
require("../models/user.model");

const getMembers = async (classId)=>{

    return await ClassMember.findAll({

        where:{
            classroomId:classId
        },

        include:[
            {
                model:User,
                attributes:[
                    "id",
                    "username",
                    "email"
                ]
            }
        ]

    });

};
const removeMember = async (
    ownerId,
    classId,
    memberId
) => {

    // Kiểm tra lớp học
    const classroom = await Course.findByPk(classId);

    if (!classroom) {
        throw new Error("Không tìm thấy lớp.");
    }

    // Chỉ chủ lớp mới được xóa
    if (classroom.ownerId != ownerId) {
        throw new Error("Bạn không có quyền.");
    }

    // Không cho chủ lớp tự xóa mình
    if (ownerId == memberId) {
        throw new Error("Không thể xóa chủ lớp.");
    }

    const member = await ClassMember.findOne({

        where: {

            classroomId: classId,

            userId: memberId

        }

    });

    if (!member) {
        throw new Error("Không tìm thấy thành viên.");
    }

    await member.destroy();

    return true;
};
module.exports = {
  joinClass,
  getJoinedClasses,
  getMembers,
  removeMember
};