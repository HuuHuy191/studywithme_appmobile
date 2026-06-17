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

router.post(
  "/join",
  authMiddleware,
  classMemberController.joinClass
);

module.exports = router;