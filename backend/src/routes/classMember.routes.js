const express =
require("express");

const router =
express.Router();

const authMiddleware =
require(
  "../middlewares/authMiddleware"
);

const classMemberController =
require(
  "../controllers/classMember.controller"
);

// Tham gia lớp
router.post(
  "/join",
  authMiddleware,
  classMemberController.joinClass
);

// Lấy danh sách lớp đã tham gia
router.get(
  "/my-classes",
  authMiddleware,
  classMemberController.getJoinedClasses
);

router.get(
    "/:classId",
    authMiddleware,
    classMemberController.getMembers
);
router.delete(
    "/:classId/:userId",
    authMiddleware,
    classMemberController.removeMember
);
module.exports = router;