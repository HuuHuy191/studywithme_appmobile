const express = require("express");
const router = express.Router();

const vocabController =
require("../controllers/vocab.controller");

const authMiddleware =
require("../middlewares/authMiddleware");

router.post(
    "/",
    authMiddleware,
    vocabController.createVocab
);

router.get(
    "/course/:courseId",
    authMiddleware,
    vocabController.getVocabs
);

router.delete(
    "/:id",
    authMiddleware,
    vocabController.deleteVocab
);
router.put(
    "/:id",
    authMiddleware,
    vocabController.updateVocab
);
module.exports = router;