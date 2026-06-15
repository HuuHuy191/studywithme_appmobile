const vocabService =
require("../services/vocab.service");

// Tạo vocab
exports.createVocab = async (req, res) => {

    try {

        const vocab =
        await vocabService.createVocab(
            req.user.id,
            req.body
        );

        res.status(201).json({
            success: true,
            data: vocab
        });

    } catch (error) {

        res.status(403).json({
            success: false,
            message: error.message
        });

    }
};

// Lấy danh sách vocab theo course
exports.getVocabs = async (req, res) => {

    try {

        const vocabs =
        await vocabService.getVocabsByCourse(
            req.user.id,
            req.params.courseId
        );

        res.json({
            success: true,
            data: vocabs
        });

    } catch (error) {

        res.status(403).json({
            success: false,
            message: error.message
        });

    }
};

// Xóa vocab
exports.deleteVocab = async (req, res) => {

    try {

        await vocabService.deleteVocab(
            req.user.id,
            req.params.id
        );

        res.json({
            success: true,
            message:
            "Deleted successfully"
        });

    } catch (error) {

        res.status(403).json({
            success: false,
            message: error.message
        });

    }
};