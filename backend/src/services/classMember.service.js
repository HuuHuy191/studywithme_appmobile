const Course =
require("../models/course.model");

const ClassMember =
require("../models/classMember.model");

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

module.exports = {
  joinClass
};